// ==PREPROCESSOR==
// @name "Skip track  every 65s (mark as played)"
// @author "marc2003"
// @import "lodash"
// @import "%fb2k_component_path%helpers.txt"
// @import "%fb2k_component_path%samples\js\common.js"
// @import "%fb2k_component_path%samples\js\panel.js"
// ==/PREPROCESSOR==

var colours = {
	buttons : RGB(255, 255, 255),
	background : RGB(30, 30, 30),
	sac : RGB(196, 30, 35),
};

//////////////////////////////////////////////////////////////

var panel = new _panel();
var buttons = new _buttons();
var bs = _scale(24);
var running = null;
var SKIP_AT = 65; // seconds
var skipped_this_track = false;
var pc = 0;

buttons.update = function () {
	var x = ((panel.w - bs * 4) / 2);
	var y = Math.round((panel.h - bs) / 2);
	this.buttons.stop = new _button(x, y, bs, bs, { char : !running ? chars.play:chars.stop, colour:!running ? colours.buttons : colours.sac}, null, function () { 
		if(running) {
			console.log("Stopping 'skip every 65s' script.");
			running = false;
		} else {
			console.log("Start 'skip every 65s' script");
			running = true;
		}
		buttons.update();
 }, !running ? 'Skip every 65s' : 'Stop script');
	this.buttons.previous = new _button(x + bs, y, bs, bs, { char : chars.prev, colour:colours.buttons }, null, function () { fb.Prev(); }, 'Previous');
	this.buttons.play = new _button(x + (bs * 2), y, bs, bs, { char : !fb.IsPlaying || fb.IsPaused ? chars.play : chars.pause, colour:colours.buttons}, null, function () { fb.PlayOrPause(); }, !fb.IsPlaying || fb.IsPaused ? 'Play' : 'Pause');
	this.buttons.next = new _button(x + (bs * 3), y, bs, bs, { char : chars.next, colour:colours.buttons }, null, function () { 
				fb.Next();
	}, 'Next');
		
}

function on_mouse_lbtn_up(x, y) {
	buttons.lbtn_up(x, y);
}

function on_mouse_leave() {
	buttons.leave();
}

function on_mouse_move(x, y) {
	buttons.move(x, y);
}

function on_mouse_rbtn_up(x, y) {
	if (buttons.buttons.stop.containsXY(x, y)) {
		fb.StopAfterCurrent = !fb.StopAfterCurrent;
		return true;
	}

	return panel.rbtn_up(x, y);
}

function on_paint(gr) {
	gr.Clear(colours.background);
	buttons.paint(gr);
}

function on_playback_pause(state) {
	    if (state) {
        console.log("Playback paused => disabling skip");
        running = false;
    } else {
        console.log("Playback resumed => enabling skip");
        running = true;
    }
	buttons.update();
	window.Repaint();
}

function on_playback_starting() {
	buttons.update();
	window.Repaint();
}

function on_playback_stop(reason) {
	// Ignore stop events caused by switching tracks
    if (reason === 2) return;
    console.log("Playback stopped => disabling skip");
    running = false;
	buttons.update();
	window.Repaint();
}

function on_playback_time(time) {
    if (!running) return;
     // read playcount (skip immediately if > 0)

    if (!skipped_this_track) {
		if(pc >= 1 && time > 5) {
		fb.Next();
		console.log("Playcount=" + pc + " => skipping immediately with 5s delay");
		skipped_this_track = true;
	}
		else if (time >= SKIP_AT) {
        console.log("Auto-skipping after 65s");
        fb.Next();
		skipped_this_track = true;
    }
}
}

function on_playback_new_track(metadb) {
	//console.log("new track => reset skip flag");
	pc = fb.TitleFormat("%play_count%").EvalWithMetadb(metadb);
	pc = parseInt(pc, 10) || 0;
	console.log("playcount = " + pc);
    skipped_this_track = false;
}

function on_playlist_stop_after_current_changed() {
	buttons.update();
	window.Repaint();
}

function on_size() {
	panel.size();
	buttons.update();
}