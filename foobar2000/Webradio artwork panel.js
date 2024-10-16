// ==PREPROCESSOR==
// @name "WebRadio artwork panel"
// @author "tartuffe"
// @import "%fb2k_component_path%helpers.txt"
// ==/PREPROCESSOR==

var url = "https://radio.bringthenoi.se/api/station/1/nowplaying";
var stream = "radio.bringthenoi.se/listen"; 
var string = null
var imageUrl = "";
var GET = 0;
var id = utils.HTTPRequestAsync(window.ID, GET, url);
var img = null;
var res = null;
var type = 0;
var lastUpdateTime = null;
var fso = new ActiveXObject("Scripting.FileSystemObject");
var nowPlayingPath = "..\\dev\\azuri-ndm\\src\\data\\now_playing.txt";
var playlistName = null

// initiate API request for JSON
function updateArt(url) {
	url = "https://radio.bringthenoi.se/api/station/1/nowplaying";
	utils.HTTPRequestAsync(window.ID, GET, url);
}

// Function to initiate the image download
function downloadImage(url) {
	utils.DownloadImageAsync(window.ID, url);
}

// start art download when JSON is retrieved | the task_id is the return value from the utils.HTTPRequestAsync call
function on_http_request_done(task_id, success, response_text, status, headers) {
    if (!success) {
        console.log(window.Name, ": ", response_text);
        return;
    }
	
    console.log(window.Name, ": ", "JSON retrieved!");
	res = JSON.parse(response_text);
	imageUrl = res.now_playing.song.art;
	url = imageUrl
	
	// write now_playing info to txt for Text Reader Panel to retrieve
	playlistName =  res.now_playing.playlist

	var nowPlayingFile = fso.CreateTextFile(nowPlayingPath, 1);
	nowPlayingFile.Write(playlistName);
	nowPlayingFile.Close();
	// send notification to other JScript panels
	window.NotifyOthers(window.Name, playlistName);

	
// Initiate the image download
downloadImage(url);
}

// Callback function called when the image download is done => repaint window
function on_download_image_done(url, image) {
    if (url === imageUrl) {
		img = image;
        window.Repaint();
    }
}

// on window paint => draw image on the panel
function on_paint(gr) {
    if (img) {
        //gr.DrawImage(img, 0, 0, img.Width, img.Height, 0, 0, img.Width, img.Height);
		gr.DrawImage(img, 0, 0, window.Width, window.Width, 0, 0, img.Width, img.Height);
    }
}

// if Radio is playing, update art every time track metadata changes (100 ms delay to make sure JSON has been updated)
function on_playback_dynamic_info_track(type) {
	var handle = fb.GetNowPlaying();
	string = handle.Path;
	if(string.search(stream)) {
	window.SetTimeout(function () {
		updateArt(url);
		console.log("updated bc playback");
	}, 100);
}
}

// update art everytime panel gets focus & playback is paused
function on_focus(is_focused) {
	if(is_focused && window.IsVisible && !fb.IsPlaying) {
	console.log(window.Name, ": ", "getting art on focus");
	updateArt(url);
	console.log(window.Name, ": ", lastUpdateTime);
	var now = Math.round(new Date().getTime() / 1000);
	lastUpdateTime = utils.TimestampToDateString(now);
	console.log(Date.now());
	console.log(window.Name, ": ", lastUpdateTime);
	}
}

/*
// Resize function to handle panel resizing
function on_size() {
    window.Repaint();
}
*/
