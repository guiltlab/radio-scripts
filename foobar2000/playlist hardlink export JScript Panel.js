// ==PREPROCESSOR==
// @name "Playlist Export Panel"
// @author "marc2003 + tartuffe"
// @import "%fb2k_component_path%helpers.txt"
// @import "%fb2k_component_path%samples\js\lodash.min.js"
// @import "%fb2k_component_path%samples\js\common.js"
// @import "%fb2k_component_path%samples\js\panel.js"
// ==/PREPROCESSOR==

// This script provides buttons to hardlink all playlists found in a custom SMP-Playlist-Manager JSON to folders specified in File operations presets
// There is also a button to check if playlist size is the same between fooobar2000, the hardlinked folder and the live radio using azuracast API
// requirements: API key should be available for API call

/////////// Original code by marc2003 ////////
var colours = {
    buttons: RGB(150, 150, 150),
    background: RGB(25, 25, 25),
    hover: RGB(255, 155, 0),
    sac: RGB(196, 30, 35),
};

var panel = new _panel();
var buttons = new _buttons();
var bs = _scale(30);

//////////// Tie function to File>JSP 3>Item idx main menu command/////////
function on_main_menu(idx) {
    if (idx === 1) {
        propertiesCleanUp();
    }
    if (idx === 3) {
        processFiles();
    }
}

/////////// Load SMP-Playlist Manager JSON & Radio API JSON ////////

// Load the filesystem object to read the JSON file
var fso = new ActiveXObject("Scripting.FileSystemObject");
var playlists = null;

function loadPlaylistManagerJSON() {

    var playlistManagerJSONPath = ".\\profile\\js_data\\playlistManager_playlist_manager.json";
    if (utils.IsFile(playlistManagerJSONPath)) {
        var file = fso.OpenTextFile(playlistManagerJSONPath, 1);
        var json = file.ReadAll();
        file.Close();
        // Parse the JSON file content from SMP-Playlist Manager
        playlists = JSON.parse(json);

    } else {
        utils.ShowPopupMessage("SMP-Playlist Manager JSON not found at " + playlistManagerJSONPath, window.Name + " Error");
    }
}

// get radio playlists from local file on panel load
var radioPlaylists = null
var playlistAPIPath = "..\\dev\\azuri-ndm\\src\\data\\playlists_API.json";
var playlistAPIPathOld = "..\\dev\\azuri-ndm\\src\\data\\playlists_API_old.json";
var playlistAPIPathBackup = "..\\dev\\azuri-ndm\\src\\data\\playlists_API_backup.json";
var file_radio = null;
var json_radio = null;
var backupMode = null;
if (utils.IsFile(playlistAPIPath)) {
    file_radio = fso.OpenTextFile(playlistAPIPath, 1);
    console.log("path is " + playlistAPIPath);
    json_radio = file_radio.ReadAll();
    //console.log(json_radio);
    file_radio.Close();
    try {
        radioPlaylists = JSON.parse(json_radio);
    } catch (error) {
        console.log(window.Name, ": " + error + " | Error using latest API JSON, switching to old one");
        playlistAPIPath = playlistAPIPathOld;
        backupMode = true;
        try {
            if (utils.IsFile(playlistAPIPath)) {
                file_radio = fso.OpenTextFile(playlistAPIPath, 1);
                json_radio = file_radio.ReadAll();
                file_radio.Close();
                radioPlaylists = JSON.parse(json_radio);

            } else {
                console.log(window.Name, ": " + error + " | Local JSON_old not found, falling back to JSON_backup");
            }
        } catch (error) {
            console.log(window.Name, ": " + error + " | Error using old API JSON, switching to backup one");
            playlistAPIPath = playlistAPIPathBackup;
            try {
                if (utils.IsFile(playlistAPIPath)) {
                    file_radio = fso.OpenTextFile(playlistAPIPath, 1);
                    json_radio = file_radio.ReadAll();
                    file_radio.Close();
                    radioPlaylists = JSON.parse(json_radio);
                } else {
                    console.log(window.Name, ": " + error + " | Local JSON_backup not found, no fallback");
                }
            }
            catch (error) {
                console.log(window.Name, ": " + error + " | New, old and backup API JSON failed!");

            }
        }

    }

}
else {
    console.log(window.Name, ": Local JSON not found, initiating API call to retrieve radio playlists data");
}

// Radio API information & headers
var apiKeyPath = "..\\dev\\azuri-ndm\\azuri.env";
if (utils.IsFile(apiKeyPath)) {
    var file_key = fso.OpenTextFile(apiKeyPath, 1);
    var key = file_key.ReadAll();
    var regex = new RegExp(/API_KEY=(.*)/);
    var apiKey = regex.exec(key)
    apiKey = apiKey[1];
    file_key.Close();
} else {
    console.log("API Key not found");
}
var url = "https://radio.bringthenoi.se/api/station/1/playlists";
var headers = JSON.stringify({
    "X-Api-Key": apiKey
});
var GET = 0;

// if local cache is too old or not available, get Playlists from API again
function getRadioPlaylistsJSON(url) {

    if (radioPlaylists) {
        file_radio = fso.GetFile(playlistAPIPath);
        var lastUpdatedTime = new Date(file_radio.DateLastModified);
        var lastUpdatedTimestamp = Math.floor(lastUpdatedTime.getTime() / 1000); // convert to seconds
        var now = utils.Now();
    }

    if (radioPlaylists && (now - lastUpdatedTimestamp < 21600 || backupMode)) {
        // use alrady loaded info from local file if local cache is recent or if backupMode activated (radio API down/malfunctioning)
        console.log(window.Name + ": Using local JSON for radio playlists");
    } else if (apiKey) {
        // refresh playlists JSON with API call
        console.log(window.Name, ": Local JSON too old, backup + initiating API call to refresh radio playlists data");
        utils.CopyFile(playlistAPIPath, playlistAPIPathOld, true);
        utils.HTTPRequestAsync(window.ID, GET, url, headers);
    } else {
        utils.ShowPopupMessage(window.Name, ": API Key not found at " + apiKeyPath + " or regex match issue", window.Name + " Error");
    }
}

// the task_id is the return value from the utils.HTTPRequestAsync call
function on_http_request_done(task_id, success, response_text, status, headers) {
    if (!success) {
        console.log(window.Name, ": ", response_text);
        return;
    }
    console.log(window.Name, ": ", "Radio API Playlists JSON retrieved!");
    radioPlaylists = response_text
    file_radio = fso.CreateTextFile("..\\dev\\azuri-ndm\\src\\data\\playlists_API.json");
    file_radio.Write(radioPlaylists);
    file_radio.Close();
    console.log("Playlists refreshed from API & written to local json");
}

// execute
getRadioPlaylistsJSON(url);

////// Variables and reqs for Playlist Switching and Hardlinking /////
var switchPlaylist = "View/Switch to playlist/"
var hardlinkTo = "File Operations/Link to/";
var preset = null;
var report = "";
var report_good = "";
var report_other = "";

// send key to press "Run" on preview dialog box
var shell = new ActiveXObject("WScript.Shell");
function sendKey(key) {
    shell.SendKeys(key);
}

// function to hardlink fb2K playlists to folders with FileOps
function hardlinkPlaylists(index) {

    if (index >= playlists.length) {
        console.log("All playlists hardlinked");
        var message = "Playlists hardlinked:\n" + report;
        var title = window.Name + " " + "Report";
        utils.ShowPopupMessage(message, title);
        report = "";
        return; // Exit when all playlists are processed
    }

    var playlist = playlists[index];
    if (!playlist.name || !playlist.preset || playlist.name.match("(folder)")) {
        // If playlistName or preset is missing, or if name contains "(folder)", immediately process the next playlist
        hardlinkPlaylists(index + 1);
        return;
    }

    // Switch to the specified playlist and grab name + item count
    fb.RunMainMenuCommand(switchPlaylist + playlist.name);
    var playlistIndex = plman.ActivePlaylist;
    var handle_list = plman.GetPlaylistItems(playlistIndex);

    // Run the context command with the preset
    console.log("run preset... " + playlist.preset);
    handle_list.RunContextCommand(hardlinkTo + playlist.preset);

    // log playlist name and item count
    report = report.concat("\n" + playlist.name + " (" + plman.GetPlaylistItemCount(playlistIndex) + " tracks)");

    // Wait for 5 seconds and then send the ENTER key, then process the next playlist
    window.SetTimeout(function () {
        if (playlist.name && playlist.preset) {
            sendKey("{ENTER}");
            window.SetTimeout(function () {
                hardlinkPlaylists(index + 1);
            }, 5000); // 5 seconds delay between each playlist processing - should be enough for the Link operation, increase for copy/move
        } else {
            console.log(window.Name + ": weird...");
            hardlinkPlaylists(index + 1);
        }
    }, 5000); // Initial 5 seconds delay after context command
}

// Check if foobar playlist + hardlinked folder have same number of items, 
// if not => it should be investigated e.g. using reFacets item#
function findMismatchPlaylistFolder(index) {

    if (index >= playlists.length) {
        console.log(window.Name + ": All playlists analyzed");
        var message = "Issues found in these playlists:\n" + report + "\n\n//////////////////////////////////////////////////////////\n\n" + "No corresponding API match:\n" + report_other + "\n\n" + "All Good:\n" + report_good;
        var title = window.Name + " " + "Report";
        utils.ShowPopupMessage(message, title);
        report = "";
        report_good = "";
        report_other = "";
        return; // Exit when all playlists are processed
    }

    var playlist = playlists[index];

    if (!playlist.preset || !playlist.name || playlist.name.match("(folder)")) {
        // ignore unfinished & folder playlists
        findMismatchPlaylistFolder(index + 1);
        return;
    }

    // Switch to the specified playlist and log it
    fb.RunMainMenuCommand(switchPlaylist + playlist.name);

    // Get the active playlist index
    var playlistIndex = plman.ActivePlaylist;

    // Get the number of items in active playlist
    var itemCountUI = plman.GetPlaylistItemCount(playlistIndex);

    // Get the corresponding playlist index on the radio WIP
    // cannot use find() because ECMA5 limit
    var itemCountAPI = null
    if (radioPlaylists) {

        for (var i = 0; i < radioPlaylists.length; i++) {
            if (radioPlaylists[i].id == playlist.idRadio) {
                radioPlaylist = radioPlaylists[i];
                itemCountAPI = radioPlaylist.num_songs
                break;
            }
        }
    }

    /////////// get item count for combined foobar playlist + hardlinked folder
    var itemCountPlaylistFolder = null;
    var playlistFolderIndex = null;
    // Switch to the specified playlist and log it
    fb.RunMainMenuCommand(switchPlaylist + playlist.name + " (folder)");

    // Get the active playlist index
    playlistFolderIndex = plman.ActivePlaylist;

    // Get the number of items in active playlist
    itemCountPlaylistFolder = plman.GetPlaylistItemCount(playlistFolderIndex);

    if (itemCountUI - itemCountAPI !== 0 || itemCountPlaylistFolder - itemCountUI !== itemCountUI) {
        if (!itemCountAPI) {
            // handle unfinished playlists not yet used on the live radio
            report_other = report_other.concat("\n", playlist.name, ": ", itemCountUI, " | Folder+fb2k: ", itemCountPlaylistFolder);
        } else if (playlist.name == "chiptune" || playlist.name == "synthwave" || playlist.name == "drum & bass" || playlist.name == "jungle" || playlist.name == "dubstep" || playlist.name == "movies" || playlist.name == "TV") {
            // handle playlists with known API mismatch (e.g. combined playlists on radio but single on foobar)
            if (itemCountPlaylistFolder - itemCountUI !== itemCountUI) {
                // folder different from playlist => check needed
                report = report.concat("\n", playlist.name, ": ", itemCountUI, " | Folder+fb2k: ", itemCountPlaylistFolder, " | API: ", itemCountAPI);
            } else {
                // folder identical to playlist => OK
                report_good = report_good.concat("\n", playlist.name, ": ", itemCountUI, " | Folder+fb2k: ", itemCountPlaylistFolder, " | API: ", itemCountAPI);
            }
        } else {
            report = report.concat("\n", playlist.name, ": ", itemCountUI, " | Folder+fb2k: ", itemCountPlaylistFolder, " | API: ", itemCountAPI);
        }
    } else if (itemCountUI - itemCountAPI == 0 || itemCountPlaylistFolder - itemCountUI == itemCountUI) {
        report_good = report_good.concat("\n", playlist.name, ": ", itemCountUI, " | Folder+fb2k: ", itemCountPlaylistFolder, " | API: ", itemCountAPI);
    } else {
        console.log(window.Name + ": wtf?");
    }
    findMismatchPlaylistFolder(index + 1);
}

buttons.update = function () {
    var x = ((panel.w - bs * 4) / 2);
    var y = Math.round((panel.h - bs) / 2);
    this.buttons.importPlaybackStatistics = new _button(x, y, bs, bs, { char: chars.folder, colour: colours.buttons }, null, function () {
        // workaround to copy path to Playback Stats in clipboard - would be better to open dialog box directly in it
        var importPlaybackStatsPath = "D:\\foobar2000\\backup";
        utils.SetClipboardText(importPlaybackStatsPath);
        fb.RunMainMenuCommand("Library/Playback Statistics/Import Statistics...");
    }, 'Import Playback Stats');
    this.buttons.hardlinkAllPlaylists = new _button(x + (bs * 1), y, bs, bs, { char: chars.shuffle, colour: colours.buttons }, null, function () {

        // Start processing the first playlist
        loadPlaylistManagerJSON();
        console.log(window.Name + ": Begin hardlinkPlaylists");
        hardlinkPlaylists(0);
    }, 'Switch to playlist and hardlink');
    this.buttons.play = new _button(x + (bs * 2), y, bs, bs, { char: chars.play, colour: !fb.IsPlaying || fb.IsPaused ? colours.buttons : colours.sac }, null, function () {
        loadPlaylistManagerJSON();
        console.log(window.Name + ": Begin radio playlist/folder/API mismatch analysis");
        findMismatchPlaylistFolder(0);
    }, "Check for mismatch (fb2k/folder/API)");
    this.buttons.checkBrokenHardlinks = new _button(x + (bs * 3), y, bs, bs, { char: chars.search, colour: colours.buttons }, null, function () {
        // Check for broken hardlinks and delete them
        // select first item in active playlist (arbitrary => necessary to select *something* to use context command)
        plman.SetPlaylistSelection(plman.ActivePlaylist, [0], true);
        var handle_list = plman.GetPlaylistSelectedItems(plman.ActivePlaylist);
        handle_list.RunContextCommand("Run service/Orphan Hardlink removal");
    }, 'Find & delete broken hardlinks');
}

/////////// Original code by marc2003 ////////

function on_mouse_lbtn_up(x, y) {
    buttons.lbtn_up(x, y);
}

function on_mouse_leave() {
    buttons.leave();
}

function on_mouse_move(x, y) {
    buttons.move(x, y);
}


/* function to stop after current track
function on_mouse_rbtn_up(x, y) {
    if (buttons.buttons.stop.containsXY(x, y)) {
        fb.StopAfterCurrent = !fb.StopAfterCurrent;
        return true;
    }

    return panel.rbtn_up(x, y);
}
*/
function on_paint(gr) {
    gr.Clear(colours.background);
    buttons.paint(gr);
}

function on_playback_pause() {
    buttons.update();
    window.Repaint();
}

function on_playback_starting() {
    buttons.update();
    window.Repaint();
}

function on_playback_stop() {
    buttons.update();
    window.Repaint();
}

function on_playlist_stop_after_current_changed() {
    buttons.update();
    window.Repaint();
}

function on_size() {
    panel.size();
    buttons.update();
}

// Workaround to use Properties dialog box > "Clean up" option automatically.
var items = null;
function propertiesCleanUp() {
    if (!items) {
        items = plman.GetPlaylistSelectedItems(plman.ActivePlaylist); // get selected items if null e.g. when calling the function on its own, outside processFiles()
        console.log("propertiesCleanUp() : no items stored at call time, grabbing items again");
    }
    // Activate foobar2000 window — make sure it's in the foreground and reselect items
    shell.AppActivate("foobar2000");
    items.RunContextCommand("Properties");
    //open the Properties window (Alt+Enter), select all fields, open context menu, go down 8 times to select+use "Clean up"
    //shell.SendKeys("%{ENTER}");
    shell.SendKeys("{DOWN}");
    shell.SendKeys("^a");
    shell.SendKeys("+{F10}");
    for (var i = 0; i < 8; i++) {
        shell.SendKeys("{DOWN}");
    }
    shell.SendKeys("{ENTER}");
    shell.SendKeys("{ESCAPE}");
    shell.SendKeys("{ENTER}");
}
// Function to process files with a bunch of operations. Badly coded so will crash if the number of commands is lower than the number of function calls
function processFiles() {
    items = plman.GetPlaylistSelectedItems(plman.ActivePlaylist);
    if (items.Count < 1 || !items.Count) {
        return utils.ShowPopupMessage("No tracks selected - aborting");
    }
    var commands = [
        { name: "Tagging/Batch attach pictures", delay: 0 }, // call first to add a back cover to remove later after optimizing filesize (in order to set padding to fixed value : the size of the back cover in question)
        { name: "Utilities/Optimize file layout + minimize file size", delay: 2000 + items.Count * 1000 },
        { name: "Cover utils/Remove all except front", delay: 2000 + items.Count * 1000 }, // must be done AFTER file opti to keep some padding!
        { name: "Cover utils/Scan for Cover Info", delay: 0 }, // no delay required because it doesn't modify files
        { name: "ReplayGain/Scan per-file track gain", delay: 2000 + items.Count * 500 }, // slowish with upsampling true peak scan < 150ms/track  
        { name: "BPM Analyser/Automatically analyse BPMs", delay: 2000 + items.Count * 2000 }, // very slow with good sample length > 4s/track
        { name: "Tagging/Scripts/Process tags for Radio Import", delay: 2000 + items.Count * 5000 },
        { name: "propertiesCleanUp()", delay: 2000 + items.Count * 50 } // short delay because tagging script is very fast
    ];

    window.setTimeout(function () {
        if (!commands[0].name) {
            return;
        }
        items.RunContextCommand(commands[0].name);
        console.log("Running " + commands[0].name + " on " + items.Count + " items");

        window.setTimeout(function () {
            if (!commands[1].name) {
                return;
            }
            items.RunContextCommand(commands[1].name);
            console.log("Running " + commands[1].name + " on " + items.Count + " items");

            window.setTimeout(function () {
                if (!commands[2].name) {
                    return;
                }
                items.RunContextCommand(commands[2].name);
                console.log("Running " + commands[2].name + " on " + items.Count + " items");

                window.setTimeout(function () {
                    if (!commands[3].name) {
                        return;
                    }
                    items.RunContextCommand(commands[3].name);
                    console.log("Running " + commands[3].name + " on " + items.Count + " items");

                    window.setTimeout(function () {
                        if (!commands[4].name) {
                            return;
                        }
                        items.RunContextCommand(commands[4].name);
                        console.log("Running " + commands[4].name + " on " + items.Count + " items");

                        window.setTimeout(function () {
                            if (!commands[5].name) {
                                return;
                            }
                            items.RunContextCommand(commands[5].name);
                            console.log("Running " + commands[5].name + " on " + items.Count + " items");

                            window.setTimeout(function () {
                                if (!commands[6].name) {
                                    return;
                                }
                                items.RunContextCommand(commands[6].name);
                                console.log("Running " + commands[6].name + " on " + items.Count + " items");

                                window.setTimeout(function () {
                                    //commands[7].name;
                                    propertiesCleanUp();
                                    console.log("Running " + commands[7].name + " on " + items.Count + " items");
                                }, commands[7].delay);

                            }, commands[6].delay);

                        }, commands[5].delay);

                    }, commands[4].delay);

                }, commands[3].delay);

            }, commands[2].delay);
        }, commands[1].delay);
    }, commands[0].delay);
}

// RG : ~2000x, took <25sec for 196 tracks => < 150m s/track reduce GREATLY
//BPM: A LOT LONGER => finished @ 17:08 around 4 sec per track, increase to 5 ?
//tagging script: very fast, reduce greatly
//last step try to reselect tracks? 41 ->