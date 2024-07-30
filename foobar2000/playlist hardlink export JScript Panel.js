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
if (utils.IsFile(playlistAPIPath)) {
    var file_radio = fso.OpenTextFile(playlistAPIPath, 1);
    var json_radio = file_radio.ReadAll();
    file_radio.Close();
    radioPlaylists = JSON.parse(json_radio);
} else {
    console.log("Local JSON not found, initiating API call to retrieve radio playlists data");
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

    if (radioPlaylists && now - lastUpdatedTimestamp < 86400) {
        // use alrady loaded info from local file
        console.log(window.Name + ": Using local JSON for radio playlists");
    } else if (apiKey) {
        // refresh playlists JSON with API call
        console.log("Local JSON too old, initiating API call to refresh radio playlists data");
        utils.HTTPRequestAsync(window.ID, GET, url, headers);
    } else {
        utils.ShowPopupMessage("API Key not found at " + apiKeyPath + " or regex match issue", window.Name + " Error");
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

// send key to press "Run" on preview dialog box
var shell = new ActiveXObject("WScript.Shell");
function sendKey(key) {
    shell.SendKeys(key);
}

// function to hardlink fb2K playlists to folders with FileOps
function hardlinkPlaylists(index) {
    console.log("start hardlinkPlaylists");
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
        console.log("All playlists analyzed");
        var message = "Playlists analyzed:\n" + report + "\n\n" + "All Good:\n" + report_good;
        var title = window.Name + " " + "Report";
        utils.ShowPopupMessage(message, title);
        report = "";
        report_good = "";
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
        report = report.concat("\n", playlist.name, ": ", itemCountUI, " | Folder+fb2k: ", itemCountPlaylistFolder, " | API: ", itemCountAPI);
    } else if (itemCountUI - itemCountAPI == 0 || itemCountPlaylistFolder - itemCountUI == itemCountUI) {
        report_good = report_good.concat("\n", playlist.name, ": ", itemCountUI, " | Folder+fb2k: ", itemCountPlaylistFolder, " | API: ", itemCountAPI);
    } else {
        console.log("wtf?");
    }
    findMismatchPlaylistFolder(index + 1);
}

buttons.update = function () {
    var x = ((panel.w - bs * 4) / 2);
    var y = Math.round((panel.h - bs) / 2);
    this.buttons.importPlaybackStatistics = new _button(x, y, bs, bs, { char: chars.folder, colour: colours.buttons }, null, function () {
        fb.RunMainMenuCommand("Library/Playback Statistics/Import Statistics...");
    }, 'Import Playback Stats');
    this.buttons.hardlinkAllPlaylists = new _button(x + (bs * 1), y, bs, bs, { char: chars.shuffle, colour: colours.buttons }, null, function () {

        // Start processing the first playlist
        loadPlaylistManagerJSON();
        hardlinkPlaylists(0);
    }, 'Switch to playlist and hardlink');
    this.buttons.play = new _button(x + (bs * 2), y, bs, bs, { char: chars.play, colour: !fb.IsPlaying || fb.IsPaused ? colours.buttons : colours.sac }, null, function () {
        loadPlaylistManagerJSON();
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