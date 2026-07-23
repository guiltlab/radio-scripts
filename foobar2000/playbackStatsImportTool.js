// ==PREPROCESSOR==
// @name "Playback Statistics Import Tool"
// @author "gadgetogogo + Claude"
// @version "1.4"
// ==/PREPROCESSOR==

// ================================================================================
//  Playback Statistics Import Tool  –  JScript Panel 3
//  Requires: foo_playcount v3.1.9+
//
//  BUTTONS
//  ┌───────────────────────────────────────────────────────┐
//  │  Transfer Statistics (opens TextBox to set values)    │
//  ├───────────────────────────────────────────────────────┤
//  │  +1 Play Count (Mark as Played)                       │
//  ├───────────────────────────────────────────────────────┤
//  │  Regenerate GC Tracks  [♻/+]  [↺]  [🗁]              │
//  ├──────────────────────────────────────────── [?]  [⚙] ─┤
//  │  [toggle]  All-tracks / Per-track mode                │
//  └══════════════════════════════════════════════════════╛ ← status strip
//
//  GENERATE GARBAGE TRACKS
//  Copies a template audio file N times into a chosen folder, assigns each copy
//  randomised title/artist/album tags so foobar treats them as unique tracks,
//  then appends them to the "Garbage collector" playlist.
//  No external tools required.  The template file itself is never modified.
//  GC tracks can be reused indefinitely in most cases, but some limitations remain
//  which require regenerating GC tracks or resetting their playback statistics,
//  the script should warn you and block operations when it happens.
//  For instance, if you change the playback stats of an unrated track by using
//  a GC track that has a stored %rating% value, the %rating% would get 
//  transferred instead of staying unrated.
//
//  Clean-before-generate toggle (default ON): before generating, all gc_XXXXXX.*
//  files are deleted from the gc folder and the playlist is cleared.
//
//  EDGE CASE (foo_playcount intended behaviour)
//  If FIRST_PLAYED or LAST_PLAYED is imported and the resulting %added% date
//  would be more recent than those timestamps, foo_playcount automatically resets
//  %added% to the earliest of first/last played.  The script warns when this will
//  occur (warning can be silenced via WARN_ADDED_RESET=false in settings).
//
//  TIMESTAMPS: Paris local time (CET/CEST, DST auto-adjusted).
//  STATUS STRIP: grey=idle  amber=working  green=ok  red=error
// ================================================================================


// ── Configuration defaults ────────────────────────────────────────────────────

var GARBAGE_PLAYLIST  = "Garbage collector";
var DEFAULT_GC_COUNT  = 100;
var GC_FILE_PREFIX    = "gc_";

var CMDS = {
    import : "Playback Statistics/Import statistics from file tags",
    copy   : "Playback Statistics/Copy statistics",
    paste  : "Playback Statistics/Paste statistics",
    reset  : "Playback Statistics/Reset statistics"
};

// Native popup menu flag constants
var MF_STRING  = 0x00000000;
var MF_GRAYED  = 0x00000001;
var MF_CHECKED = 0x00000008;

var T_AFTER_TAG_WRITE = 300;
var T_AFTER_IMPORT    = 500;
var T_BEFORE_PASTE    = 200;


// ── Persistent settings ───────────────────────────────────────────────────────

var g_gc_folder   = window.GetProperty("gc_folder",    "");
var g_gc_count    = window.GetProperty("gc_count",     DEFAULT_GC_COUNT);
var g_gc_template = window.GetProperty("gc_template",  "");
var g_gc_clean         = window.GetProperty("gc_clean",          true);
var g_gc_auto_regen    = window.GetProperty("gc_auto_regen",    false);
var g_warn_added_reset = window.GetProperty("warn_added_reset",  true);
var g_mark_natural     = window.GetProperty("mark_natural",     false);
var g_per_track        = window.GetProperty("per_track_mode",   false);
var g_compact          = window.GetProperty("compact_mode",     false);


// ── Colours & fonts ───────────────────────────────────────────────────────────

function RGB(r, g, b) {
    return (0xff000000 | ((r & 0xff) << 16) | ((g & 0xff) << 8) | (b & 0xff)) >>> 0;
}
var C = {
    bg          : RGB( 18,  18,  24),
    btn_idle    : RGB( 35,  82, 145),
    btn_hover   : RGB( 52, 112, 192),
    btn_busy    : RGB( 28,  36,  48),
    btn_border  : RGB( 70, 135, 225),
    btn2_idle   : RGB( 30,  68,  55),
    btn2_hover  : RGB( 42,  95,  72),
    btn2_border : RGB( 55, 140, 100),
    btn3_idle   : RGB( 55,  40,  18),
    btn3_hover  : RGB( 88,  62,  24),
    btn3_border : RGB(150, 100,  40),
    icon_idle   : RGB( 30,  32,  42),
    icon_hover  : RGB( 52,  56,  72),
    icon_border : RGB( 62,  67,  85),
    icon_text   : RGB(140, 150, 170),
    text        : RGB(215, 230, 255),
    text2       : RGB(160, 225, 185),
    text3       : RGB(210, 175, 110),
    text_busy   : RGB( 65,  78,  98),
    tog_off     : RGB( 30,  32,  42),
    tog_on      : RGB( 38,  76,  52),
    tog_hover   : RGB( 45,  50,  65),
    tog_border  : RGB( 58,  63,  82),
    tog_text    : RGB(150, 160, 180),
    tog_on_txt  : RGB(115, 205, 140),
    bar_idle    : RGB( 68,  73,  86),
    bar_ok      : RGB( 58, 170,  85),
    bar_err     : RGB(182,  52,  45),
    bar_step    : RGB(170, 145,  38)
};
var FONT_BTN  = JSON.stringify({ Name: "Segoe UI", Size: 12 });
var FONT_SM   = JSON.stringify({ Name: "Segoe UI", Size: 10 });
var FONT_ICON = JSON.stringify({ Name: "Segoe UI", Size: 11 });
var FONT_ICON_LG = JSON.stringify({ Name: "Segoe UI", Size: 16 });


// ── Layout ────────────────────────────────────────────────────────────────────

var PAD        = 6;
var BAR_H      = 5;
var BTN2_H     = 22;
var BTN3_H     = 22;
var TOG_H      = 20;
var ICON_BTN_W = 22;
var ROW_GAP    = 4;

var _BELOW = ROW_GAP + BTN2_H + ROW_GAP + BTN3_H + ROW_GAP + TOG_H + ROW_GAP + BAR_H;

// Compact mode constants
var CROW_H   = 26;   // height of the single compact row
var CMORE_W  = 30;   // width of the "..." button
var CPLAY_W  = 40;   // width of the "+1" button
var CIMPORT_W = 40;  // width of the import button

// Menu item definitions for compact mode "..." dropdown.
// type: "item" | "sep"  action: function  stateLabel: function→string (optional)
// Used with window.CreatePopupMenu() for a native OS floating context menu.
function _menuItems() {
    return [
        { type:"item", label:"Regenerate GC Tracks",
          action: function(){ RunGenerateGC(); } },
        { type:"item",
          stateLabel: function(){ return g_gc_clean ? "\u267b  Clean mode (toggle)" : "+  Append mode (toggle)"; },
          action: function(){ g_gc_clean=!g_gc_clean; window.SetProperty("gc_clean",g_gc_clean); } },
        { type:"item", label:"\u21ba  Reset GC Stats",
          action: function(){ RunResetGC(); } },
        { type:"item", label:"\uD83D\uDDC1  Open GC Folder",
          action: function(){ RunOpenGCFolder(); } },
        { type:"sep" },
        { type:"item",
          stateLabel: function(){ return g_per_track ? "[ \u2022 ]  Per-track mode (toggle)" : "[   ]  All-tracks mode (toggle)"; },
          action: function(){ g_per_track=!g_per_track; window.SetProperty("per_track_mode",g_per_track); } },
        { type:"sep" },
        { type:"item", label:"?  Help",
          action: function(){ utils.ShowPopupMessage(HELP_TEXT,"Stats Transfer \u2013 Help"); } },
        { type:"item", label:"\u2699  Settings",
          action: function(){ showSettings(); } },
        { type:"sep" },
        { type:"item", label:"Exit compact mode",
          action: function(){ g_compact=false; window.SetProperty("compact_mode",false); } }
    ];
}

var g_busy        = false;
var g_status      = "idle";
var g_btn_hover   = false;
var g_btn2_hover  = false;
var g_btn3_hover  = false;
var g_clean_hover = false;
var g_reset_hover = false;
var g_openfld_hover = false;
var g_cog_hover   = false;
var g_help_hover  = false;
var g_tog_hover   = false;

// Generation state (cleared when done)
var g_gen_gc_pl        = -1;   // gc playlist index during generation
var g_gen_prev_count   = 0;    // playlist size before AddLocations
var g_gen_expected     = 0;    // how many files we tried to add
var g_gen_paths        = null; // array of dest paths added

function _btnRect() {
    return { x: PAD, y: PAD,
             w: window.Width - PAD * 2,
             h: window.Height - PAD * 2 - _BELOW };
}
function _btn2Rect() {
    var b = _btnRect();
    return { x: PAD, y: b.y + b.h + ROW_GAP, w: window.Width - PAD * 2, h: BTN2_H };
}
// BTN3 row: main button + 3 icon buttons (clean-toggle, reset, open-folder)
// The 3 icons sit flush right on the same row, each ICON_BTN_W wide.
var BTN3_ICONS = 3;   // number of icon buttons on btn3 row
function _btn3Rect() {
    var b = _btn2Rect();
    var icons_w = ICON_BTN_W * BTN3_ICONS + ROW_GAP * (BTN3_ICONS - 1);
    return { x: PAD, y: b.y + b.h + ROW_GAP,
             w: window.Width - PAD * 2 - icons_w - ROW_GAP, h: BTN3_H };
}
// Helper: nth icon on the btn3 row (0-indexed from right edge of btn3)
function _btn3Icon(n) {
    var b3 = _btn3Rect();
    return { x: b3.x + b3.w + ROW_GAP + n * (ICON_BTN_W + ROW_GAP),
             y: b3.y, w: ICON_BTN_W, h: BTN3_H };
}
function _cleanRect()   { return _btn3Icon(0); }   // clean/append toggle
function _resetRect()   { return _btn3Icon(1); }   // reset GC stats
function _openfldRect() { return _btn3Icon(2); }   // open GC folder
function _togRect() {
    var icons_w = ICON_BTN_W * 2 + ROW_GAP;
    return { x: PAD, y: window.Height - BAR_H - ROW_GAP - TOG_H,
             w: window.Width - PAD * 2 - icons_w - ROW_GAP, h: TOG_H };
}
function _helpRect() {
    var tr = _togRect();
    return { x: tr.x + tr.w + ROW_GAP, y: tr.y, w: ICON_BTN_W, h: TOG_H };
}
function _cogRect() {
    var hr = _helpRect();
    return { x: hr.x + hr.w + ROW_GAP, y: hr.y, w: ICON_BTN_W, h: TOG_H };
}
// ── Compact mode layout ─────────────────────────────────────────────────────
function _cRowRect() {  // the single compact row
    return { x: PAD, y: PAD, w: window.Width - PAD * 2, h: CROW_H };
}
function _cMoreRect() {  // "..." button, rightmost
    var r = _cRowRect();
    return { x: r.x + r.w - CMORE_W, y: r.y, w: CMORE_W, h: r.h };
}
function _cPlayRect() {  // "+1" button, left of "..."
    var mr = _cMoreRect();
    return { x: mr.x - ROW_GAP - CPLAY_W, y: mr.y, w: CPLAY_W, h: mr.h };
}
function _cImportRect() {  // import button, fixed width same as +1
    var pr = _cPlayRect();
    return { x: pr.x - ROW_GAP - CIMPORT_W, y: pr.y, w: CIMPORT_W, h: pr.h };
}
function _inRect(r, x, y) {
    return x >= r.x && x < r.x + r.w && y >= r.y && y < r.y + r.h;
}
function _statusColour() {
    return g_status === "ok"   ? C.bar_ok
         : g_status === "err"  ? C.bar_err
         : g_status === "step" ? C.bar_step
         :                       C.bar_idle;
}


// ── Paris timezone ────────────────────────────────────────────────────────────

function _lastSundayUTC(year, month0, hourUTC) {
    var day31 = new Date(Date.UTC(year, month0, 31));
    return new Date(Date.UTC(year, month0, 31 - day31.getUTCDay(), hourUTC, 0, 0));
}
function parisTZOffsetSec(utcMs) {
    var year = new Date(utcMs).getUTCFullYear();
    var on   = _lastSundayUTC(year, 2, 1);
    var off  = _lastSundayUTC(year, 9, 1);
    return (utcMs >= on.getTime() && utcMs < off.getTime()) ? 7200 : 3600;
}
function tsToParisStr(ts) {
    if (!ts || ts <= 0) return "";
    var utcMs = ts * 1000, offset = parisTZOffsetSec(utcMs);
    var d = new Date(utcMs + offset * 1000);
    var p = function(n) { return n < 10 ? "0"+n : ""+n; };
    return d.getUTCFullYear()+"-"+p(d.getUTCMonth()+1)+"-"+p(d.getUTCDate())
          +" "+p(d.getUTCHours())+":"+p(d.getUTCMinutes())+":"+p(d.getUTCSeconds());
}
function parseParisDate(s) {
    s = (s || "").trim();
    if (!s) return null;
    var m = s.match(/^(\d{4})[\/\-.](\d{1,2})[\/\-.](\d{1,2})(?:[T ](\d{1,2}):(\d{2})(?::(\d{2}))?)?$/);
    if (!m) throw new Error('Bad date: "' + s + '"\n(use YYYY-MM-DD HH:MM:SS in Paris time)');
    var approx = new Date(Date.UTC(+m[1], +m[2]-1, +m[3], m[4]|0, m[5]|0, m[6]|0));
    if (isNaN(approx.getTime())) throw new Error('Invalid date: "' + s + '"');
    return new Date(approx.getTime() - parisTZOffsetSec(approx.getTime()) * 1000);
}
function dateToFiletime(d) {
    var sec1601 = Math.floor(d.getTime() / 1000) + 11644473600;
    return (sec1601 * 10000).toString() + "000";
}
function foobarLocalToTs(s) {
    if (!s || s === "?" || s === "N/A") return 0;
    return utils.DateStringToTimestamp(s) || 0;
}


// ── Title-format readers ──────────────────────────────────────────────────────

var TFO_PC    = fb.TitleFormat("$if2(%play_count%,0)");
var TFO_RAT      = fb.TitleFormat("$if2(%rating%,0)");    // 0 for both unset and explicit 0
var TFO_RAT_ISSET = fb.TitleFormat("$if(%rating%,1,0)"); // 1 if rating is set, 0 if unset
var TFO_ADDED = fb.TitleFormat("%added%");
var TFO_FP    = fb.TitleFormat("%first_played%");
var TFO_LP    = fb.TitleFormat("%last_played%");
var TFO_TITLE = fb.TitleFormat("%artist% - %title%");
var TFO_DUR   = fb.TitleFormat("%length_seconds_fp%");  // floating-point seconds

// ── Tooltip ───────────────────────────────────────────────────────────────────
var g_tooltip = window.CreateTooltip();
g_tooltip.SetMaxWidth(600);

var TOOLTIP = {
    btn1    : "Select target tracks, then click. A 'Garbage collector' playlist\n"
            + "with at least as many tracks as selected is required.\n"
            + "Use the Regenerate GC Tracks button to generate them automatically.",
    clean   : "Toggle between clean mode (regenerate garbage collector tracks entirely) and append mode (add new garbage collector tracks to existing ones)",
    reset   : "Reset Playback Statistics of Garbage Collector tracks",
    openfld : "Open Garbage Collector folder",
    help    : "Help",
    cog     : "Settings"
};

function readStats(h) {
    var pc       = parseInt(TFO_PC.EvalWithMetadb(h), 10);
    var rat_set  = TFO_RAT_ISSET.EvalWithMetadb(h) === "1";
    var rat      = rat_set ? parseInt(TFO_RAT.EvalWithMetadb(h), 10) : -1;
    // rating: -1 = unset (no foo_playcount rating stored)
    //          0 = explicitly rated 0
    //        1-5 = rated
    return {
        play_count   : isNaN(pc) ? 0 : pc,
        rating       : (rat_set && !isNaN(rat)) ? rat : -1,
        added        : foobarLocalToTs(TFO_ADDED.EvalWithMetadb(h)),
        first_played : foobarLocalToTs(TFO_FP.EvalWithMetadb(h)),
        last_played  : foobarLocalToTs(TFO_LP.EvalWithMetadb(h))
    };
}


// ── TextBox helpers ───────────────────────────────────────────────────────────

var HELP_TEXT =
    "Timestamps are in PARIS local time (CET/CEST auto-adjusted).\n"
  + "Format: YYYY-MM-DD HH:MM:SS  or  YYYY-MM-DD\n\n"
  + "Leave a field blank  =  preserve that track's current value.\n\n"
  + "PLAY_COUNT            : non-negative integer\n"
  + "FIRST_PLAYED / LAST_PLAYED : any timestamp\n"
  + "ADDED                 : any timestamp\n"
  + "RATING                : integer 0-5\n\n"
  + "Per-track mode: blocks are separated by --- lines.\n"
  + "Lines starting with # are comments and are ignored.\n\n"
  + "REQUIREMENTS\n"
  + "  \u2022 foo_playcount v3.1.9+\n"
  + "  \u2022 A 'Garbage collector' playlist with >= N expendable audio files.\n"
  + "    Use 'Regenerate GC Tracks' to generate them automatically.\n"
  + "    GC tracks can be reused indefinitely.\n\n"
  + "EDGE CASE\n"
  + "  If FIRST or LAST_PLAYED is imported and %added% ends up more recent\n"
  + "  than those timestamps, foo_playcount will auto-reset %added% to the\n"
  + "  earliest play date.  A warning is shown when this will occur\n"
  + "  (disable via WARN_ADDED_RESET=false in \u2699 Settings).";

function _statsToBlock(stats, idx, total) {
    var h = (idx !== undefined) ? "# [" + (idx+1) + "/" + total + "]" : "#";
    return h + "\n"
         + "PLAY_COUNT   = " + stats.play_count + "\n"
         + "FIRST_PLAYED = " + (stats.first_played ? tsToParisStr(stats.first_played) : "") + "\n"
         + "LAST_PLAYED  = " + (stats.last_played  ? tsToParisStr(stats.last_played)  : "") + "\n"
         + "ADDED        = " + (stats.added        ? tsToParisStr(stats.added)        : "") + "\n"
         + "RATING       = " + (stats.rating >= 0 ? stats.rating : "");  // "" = unset
}
function buildAllText(tgt_handles) { return _statsToBlock(readStats(tgt_handles.GetItem(0))); }
function buildPerTrackText(tgt_handles) {
    var n = tgt_handles.Count, parts = [];
    for (var i = 0; i < n; i++) {
        var h = tgt_handles.GetItem(i);
        parts.push(_statsToBlock(readStats(h), i, n).replace("#", "# " + TFO_TITLE.EvalWithMetadb(h)));
    }
    return parts.join("\n---\n");
}


// ── TextBox parser ────────────────────────────────────────────────────────────

function _parseBlock(text) {
    var r = { play_count: null, rating: null, added: null, first_played: null, last_played: null };
    var lines = text.split(/\r?\n/);
    for (var i = 0; i < lines.length; i++) {
        var line = lines[i].trim();
        if (!line || line.charAt(0) === "#") continue;
        var eq = line.indexOf("="); if (eq < 0) continue;
        var key = line.substring(0, eq).trim().toUpperCase();
        var val = line.substring(eq + 1).trim();
        if (!val) continue;
        switch (key) {
            case "PLAY_COUNT":   r.play_count   = val; break;
            case "RATING":       r.rating       = val; break;
            case "ADDED":        r.added        = val; break;
            case "FIRST_PLAYED": r.first_played = val; break;
            case "LAST_PLAYED":  r.last_played  = val; break;
        }
    }
    return r;
}
function parseTextBoxResult(raw, per_track, n) {
    if (!per_track) return [_parseBlock(raw)];
    var blocks = raw.split(/\n---[^\n]*/), results = [];
    for (var i = 0; i < n; i++) results.push(_parseBlock(i < blocks.length ? blocks[i] : ""));
    return results;
}


// ── Validation ────────────────────────────────────────────────────────────────

function validateBlock(b, label) {
    if (b.play_count !== null && !/^\d+$/.test(b.play_count))
        throw new Error(label + "PLAY_COUNT must be a non-negative integer.");
    if (b.rating !== null) {
        var rv = parseInt(b.rating, 10);
        if (isNaN(rv) || rv < 0 || rv > 5) throw new Error(label + "RATING must be 0-5.");
    }
    parseParisDate(b.added); parseParisDate(b.first_played); parseParisDate(b.last_played);
}


// ── Value resolvers ───────────────────────────────────────────────────────────

function resolveDate(user_str, existing_ts) {
    if (user_str !== null) return parseParisDate(user_str);
    if (existing_ts > 0)   return new Date(existing_ts * 1000);
    return null;
}
function resolveInt(user_str, existing_int) {
    if (user_str !== null) return String(parseInt(user_str, 10));
    if (existing_int > 0)  return String(existing_int);
    return null;
}
// resolveRating:
//   user provided a value → use it (including "0")
//   target has a rating set (>= 0) → preserve it (including explicit 0)
//   target rating is unset (-1) → return null: do NOT write RATING tag.
//     In this case checkGCContamination blocks the op if the GC track
//     already has a %rating% value that would bleed into the target.
function resolveRating(user_str, existing_int) {
    if (user_str !== null) return String(parseInt(user_str, 10));
    if (existing_int >= 0) return String(existing_int);  // includes explicit 0
    return null;  // target is unset; leave RATING tag absent
}
function resolvePlayCount(user_str, existing_int) {
    if (user_str !== null)  return user_str;
    if (existing_int >= 0)  return String(existing_int);
    return null;
}


// ── Added-reset edge-case check ───────────────────────────────────────────────
//
//  foo_playcount v3.1.9+ behaviour: if FIRST_PLAYED_TIMESTAMP or
//  LAST_PLAYED_TIMESTAMP is imported and the %added% date (whether imported or
//  already on the track) ends up more recent than those timestamps, foo_playcount
//  automatically resets %added% to the earliest of first/last played.
//  This is intentional and harmless for most workflows, but we warn the user so
//  they are not surprised.  The warning can be silenced via WARN_ADDED_RESET=false.
//
//  Returns an array of warning strings (one per affected track), or [] if all ok.

function checkAddedResetWarnings(resolved_per_track, n) {
    var warnings = [];
    for (var i = 0; i < n; i++) {
        var r  = resolved_per_track[i];
        var lb = (n > 1) ? "Track " + (i+1) + ": " : "";
        // earliest play timestamp
        var earliest_play = 0;
        if (r.fp_ts > 0 && r.lp_ts > 0) earliest_play = Math.min(r.fp_ts, r.lp_ts);
        else if (r.fp_ts > 0)            earliest_play = r.fp_ts;
        else if (r.lp_ts > 0)            earliest_play = r.lp_ts;
        if (earliest_play > 0 && r.added_ts > 0 && r.added_ts > earliest_play) {
            warnings.push(lb + "%added% " + tsToParisStr(r.added_ts)
                + " is more recent than earliest play " + tsToParisStr(earliest_play)
                + "\n    \u2192 foo_playcount will auto-reset %added% to " + tsToParisStr(earliest_play));
        }
    }
    return warnings;
}


// ── GC contamination check ──────────────────────────────────────────────────
//
//  When GC tracks are reused without being reset, their foo_playcount DB may
//  still hold FIRST_PLAYED / LAST_PLAYED values from a prior operation.  Since
//  it is impossible to "un-set" these via tag import (importing an empty or zero
//  timestamp has no effect), the only safe resolution is to warn the user and
//  abort — they must run Reset statistics on the GC tracks first.
//
//  Also checks rating: if the target is unrated (no rating stored) we write
//  no RATING tag; if the GC track already has a %rating% in its DB it would
//  bleed into the target and must be blocked.
//
//  resolved entries must include: { rating_unset, fp_ts, lp_ts }

function checkGCContamination(gc_sub, resolved_per_track, n) {
    var warnings = [];
    for (var i = 0; i < n; i++) {
        var r  = resolved_per_track[i];
        var gh = gc_sub.GetItem(i);
        var lb = (n > 1) ? "GC track " + (i+1) + ": " : "";
        var gc_rat_set = TFO_RAT_ISSET.EvalWithMetadb(gh) === "1";
        var gc_fp      = foobarLocalToTs(TFO_FP.EvalWithMetadb(gh));
        var gc_lp      = foobarLocalToTs(TFO_LP.EvalWithMetadb(gh));
        // Rating: if target is unset we write no RATING tag; if GC already
        // has a rating in its foo_playcount DB it would bleed into the target.
        if (r.rating_unset && gc_rat_set)
            warnings.push(lb + "GC track has a %rating% value but the target is unrated\n"
                + "    \u2192 Reset GC track stats before running this operation.");
        if (r.fp_ts === 0 && gc_fp > 0)
            warnings.push(lb + "GC track has %first_played% = " + tsToParisStr(gc_fp)
                + " but the target should have none\n"
                + "    \u2192 Reset GC track stats before running this operation.");
        if (r.lp_ts === 0 && gc_lp > 0)
            warnings.push(lb + "GC track has %last_played% = " + tsToParisStr(gc_lp)
                + " but the target should have none\n"
                + "    \u2192 Reset GC track stats before running this operation.");
    }
    return warnings;
}

// ── Strip playback-stat tags from GC tracks after each operation ─────────────
//
//  Removes RATING, ADDED_TIMESTAMP, FIRST_PLAYED_TIMESTAMP, LAST_PLAYED_TIMESTAMP
//  file tags from the GC tracks once the paste is done, so leftover tag values
//  cannot affect subsequent operations.  The foo_playcount DB values on the GC
//  tracks are unaffected (only file tags are cleared here); FIRST/LAST_PLAYED in
//  the DB are guarded by checkGCContamination before each operation.

function _stripGCTags(gc_sub, n) {
    var strip = [];
    for (var i = 0; i < n; i++)
        strip.push({ "RATING": [], "ADDED_TIMESTAMP": [],
                     "FIRST_PLAYED_TIMESTAMP": [], "LAST_PLAYED_TIMESTAMP": [] });
    try { gc_sub.UpdateFileInfoFromJSON(JSON.stringify(strip)); } catch(e) {}
}


// ── Shared transfer chain ─────────────────────────────────────────────────────

function _runChain(gc_sub, tgt, tag_arr, n) {
    g_busy = true; g_status = "step"; window.Repaint();
    try { gc_sub.UpdateFileInfoFromJSON(JSON.stringify(tag_arr)); }
    catch (e) {
        gc_sub.Dispose(); tgt.Dispose();
        g_busy = false; g_status = "err"; window.Repaint();
        utils.ShowPopupMessage("Failed to write tags to garbage tracks:\n\n" + e.message
            + "\n\nCheck files are not read-only.", "Stats Transfer \u2013 Tag Error");
        return;
    }
    // Bulk chain: import all gc tracks → copy all → paste to all targets.
    // gc_sub is kept alive until after paste so we can strip its file tags
    // for clean reuse on the next operation.
    window.SetTimeout(function () {
        gc_sub.RunContextCommand(CMDS.import);
        window.SetTimeout(function () {
            gc_sub.RunContextCommand(CMDS.copy);
            window.SetTimeout(function () {
                tgt.RunContextCommand(CMDS.paste);
                tgt.Dispose();
                // Strip playback-stat file tags from GC tracks after paste
                // so stale tag values cannot affect the next reuse.
                _stripGCTags(gc_sub, n);
                gc_sub.Dispose();
                g_busy = false; g_status = "ok"; window.Repaint();
            }, T_BEFORE_PASTE);
        }, T_AFTER_IMPORT);
    }, T_AFTER_TAG_WRITE);
}


// ── Shared setup ─────────────────────────────────────────────────────────────

function _setupTransfer(op_name) {
    var tgt = plman.GetPlaylistSelectedItems(plman.ActivePlaylist);
    var n   = tgt.Count;
    if (n === 0) {
        tgt.Dispose();
        utils.ShowPopupMessage("No tracks selected.\nSelect target tracks first.", op_name);
        return null;
    }
    var gc_pl = plman.FindPlaylist(GARBAGE_PLAYLIST);
    if (gc_pl < 0) {
        tgt.Dispose();
        utils.ShowPopupMessage('Playlist "' + GARBAGE_PLAYLIST + '" not found.\n'
            + 'Use "Regenerate GC Tracks" to create one.',
            op_name + " \u2013 Setup");
        return null;
    }
    var gc_size = plman.GetPlaylistItemCount(gc_pl);
    if (gc_size < n) {
        tgt.Dispose();
        utils.ShowPopupMessage('Not enough tracks in "' + GARBAGE_PLAYLIST + '".\n\n'
            + 'Selected: ' + n + '  Available: ' + gc_size
            + '\n\nRegenerate GC tracks or add files manually.',
            op_name + " \u2013 Setup");
        return null;
    }
    var gc_all = plman.GetPlaylistItems(gc_pl);
    var gc_sub = gc_all.Clone(); gc_all.Dispose();
    if (gc_sub.Count > n) gc_sub.RemoveFromIdx(n, gc_sub.Count - n);
    var tgt_stats = [];
    for (var i = 0; i < n; i++) tgt_stats.push(readStats(tgt.GetItem(i)));
    return { tgt: tgt, gc_sub: gc_sub, tgt_stats: tgt_stats, n: n };
}


// ── Settings ─────────────────────────────────────────────────────────────────

function showSettings() {
    var cur =
          "# GC_FOLDER        : folder where generated files will be written.\n"
        + "# GC_COUNT         : number of GC tracks to generate.\n"
        + "# GC_TEMPLATE      : path to the audio file used as copy template.\n"
        + "# GC_CLEAN         : true = delete old gc_* files and clear playlist before regenerating.\n"
        + "# GC_AUTO_REGEN    : true = auto-regenerate GC tracks before every transfer operation\n"
        + "#                  (forces GC_CLEAN=true; prompted for template/folder on first run).\n"
        + "# WARN_ADDED_RESET : true = warn when foo_playcount will auto-reset %added% because\n"
        + "#                  FIRST/LAST_PLAYED is earlier than the imported ADDED date.\n"
        + "# MARK_NATURAL     : true = stagger last_played in Mark as Played (track1=now,\n"
        + "#                  track2=now+dur(1), etc. May land slightly in the future.\n"
        + "# COMPACT_MODE     : true = single-row compact layout (import + +1 + ... menu)\n\n"
        + "GC_FOLDER        = " + g_gc_folder   + "\n"
        + "GC_COUNT         = " + g_gc_count    + "\n"
        + "GC_TEMPLATE      = " + g_gc_template + "\n"
        + "GC_CLEAN         = " + (g_gc_clean ? "true" : "false") + "\n"
        + "GC_AUTO_REGEN    = " + (g_gc_auto_regen ? "true" : "false") + "\n"
        + "WARN_ADDED_RESET = " + (g_warn_added_reset ? "true" : "false") + "\n"
        + "MARK_NATURAL     = " + (g_mark_natural ? "true" : "false") + "\n"
        + "COMPACT_MODE     = " + (g_compact ? "true" : "false");
    var raw;
    try {
        raw = utils.TextBox(
            "Settings for Regenerate GC Tracks.",
            "Stats Transfer \u2013 Settings", cur);
    } catch (e) { return; }

    var lines = raw.split(/\r?\n/);
    for (var i = 0; i < lines.length; i++) {
        var line = lines[i].trim();
        if (!line || line.charAt(0) === "#") continue;
        var eq = line.indexOf("="); if (eq < 0) continue;
        var key = line.substring(0, eq).trim().toUpperCase();
        var val = line.substring(eq + 1).trim();
        switch (key) {
            case "GC_FOLDER":
                if (val) { g_gc_folder = val;   window.SetProperty("gc_folder",   g_gc_folder);   }
                break;
            case "GC_COUNT":
                var cnt = parseInt(val, 10);
                if (!isNaN(cnt) && cnt > 0) { g_gc_count = cnt; window.SetProperty("gc_count", g_gc_count); }
                break;
            case "GC_TEMPLATE":
                if (val) { g_gc_template = val; window.SetProperty("gc_template", g_gc_template); }
                break;
            case "GC_CLEAN":
                g_gc_clean = (val.toLowerCase() !== "false");
                window.SetProperty("gc_clean", g_gc_clean);
                break;
            case "GC_AUTO_REGEN":
                g_gc_auto_regen = (val.toLowerCase() === "true");
                window.SetProperty("gc_auto_regen", g_gc_auto_regen);
                break;
            case "WARN_ADDED_RESET":
                g_warn_added_reset = (val.toLowerCase() !== "false");
                window.SetProperty("warn_added_reset", g_warn_added_reset);
                break;
            case "MARK_NATURAL":
                g_mark_natural = (val.toLowerCase() === "true");
                window.SetProperty("mark_natural", g_mark_natural);
                break;
            case "COMPACT_MODE":
                g_compact = (val.toLowerCase() === "true");
                window.SetProperty("compact_mode", g_compact);
                break;
        }
    }
    window.Repaint();
}


// ── Utility: random hex string ────────────────────────────────────────────────

function _randomHex(len) {
    var s = "";
    while (s.length < len) s += Math.floor(Math.random() * 0x100000000).toString(16);
    return s.substring(0, len);
}


// ── Utility: get file extension from path ─────────────────────────────────────

function _ext(path) {
    var m = path.match(/\.([^.\\\/]+)$/);
    return m ? m[0] : "";   // includes the dot, e.g. ".flac"
}


// ════════════════════════════════════════════════════════════════════════════
//  GENERATE GARBAGE COLLECTOR TRACKS
// ════════════════════════════════════════════════════════════════════════════

function RunGenerateGC() {
    if (g_busy) return;

    // ── 1. Resolve template path ──────────────────────────────────────────────

    // Check stored template is still accessible
    if (g_gc_template && !utils.IsFile(g_gc_template)) {
        utils.ShowPopupMessage(
            "Template file is no longer accessible:\n" + g_gc_template
            + "\n\nPlease select a new template file.",
            "Regenerate GC Tracks \u2013 Missing Template");
        g_gc_template = "";
        window.SetProperty("gc_template", "");
    }

    if (!g_gc_template) {
        try {
            var tmpl = utils.InputBox(
                "Enter the full path to an audio file to use as the copy template.\n"
                + "This file will be copied N times; its content is never modified.\n"
                + "Tip: use a small/short file to save disk space.",
                "Regenerate GC Tracks \u2013 Template",
                "", true);
            tmpl = tmpl.trim();
            if (!tmpl) { utils.ShowPopupMessage("No path entered.", "Regenerate GC Tracks"); return; }
            if (!utils.IsFile(tmpl)) {
                utils.ShowPopupMessage("File not found:\n" + tmpl, "Regenerate GC Tracks"); return;
            }
            g_gc_template = tmpl;
            window.SetProperty("gc_template", g_gc_template);
        } catch (e) { return; }
    }

    // ── 2. Resolve output folder ──────────────────────────────────────────────

    if (!g_gc_folder) {
        try {
            var fld = utils.InputBox(
                "Enter the folder path where generated files will be written.\n"
                + "The folder will be created if it does not exist.",
                "Regenerate GC Tracks \u2013 Output Folder",
                "", true);
            fld = fld.trim();
            if (!fld) { utils.ShowPopupMessage("No folder entered.", "Regenerate GC Tracks"); return; }
            g_gc_folder = fld;
            window.SetProperty("gc_folder", g_gc_folder);
        } catch (e) { return; }
    }

    // Ensure output folder exists
    if (!utils.CreateFolder(g_gc_folder)) {
        utils.ShowPopupMessage("Could not create folder:\n" + g_gc_folder,
            "Regenerate GC Tracks \u2013 Error");
        return;
    }

    // Normalise folder path (ensure trailing backslash)
    var folder = g_gc_folder;
    if (folder.charAt(folder.length - 1) !== "\\") folder += "\\";

    var ext = _ext(g_gc_template);

    // ── 3. Clean step (if enabled) ────────────────────────────────────────────

    if (g_gc_clean) {
        // Delete all existing gc_XXXXXX* files from the folder
        var old_files;
        try { old_files = utils.Glob(folder + GC_FILE_PREFIX + "*").toArray(); }
        catch (e) { old_files = []; }
        for (var di = 0; di < old_files.length; di++) utils.RemovePath(old_files[di]);

        // Clear the GC playlist (find it if it exists; don't create it yet)
        var gc_pl_clean = plman.FindPlaylist(GARBAGE_PLAYLIST);
        if (gc_pl_clean >= 0) plman.ClearPlaylist(gc_pl_clean);
    }

    // ── 4. Copy template N times with randomised filenames ────────────────────
    //
    //  Each copy gets a unique 12-char hex suffix in its filename.  This prevents
    //  foobar from treating any two copies as the "same file" based on path alone,
    //  and gives each copy a unique identity before we even write its tags.

    var paths = [];
    var copy_errors = 0;
    for (var ci = 0; ci < g_gc_count; ci++) {
        var dest = folder + GC_FILE_PREFIX + _randomHex(12) + ext;
        if (utils.CopyFile(g_gc_template, dest, true)) {
            paths.push(dest);
        } else {
            copy_errors++;
        }
    }

    if (paths.length === 0) {
        utils.ShowPopupMessage(
            "Could not copy any files to:\n" + folder
            + "\n\nCheck that the folder is writable and the template is accessible.",
            "Regenerate GC Tracks \u2013 Error");
        return;
    }
    if (copy_errors > 0) {
        utils.ShowPopupMessage(
            copy_errors + " of " + g_gc_count + " file copies failed.\n"
            + "Proceeding with " + paths.length + " files.",
            "Regenerate GC Tracks \u2013 Partial Warning");
    }

    // ── 5. Add files to GC playlist ──────────────────────────────────────────

    var gc_pl = plman.FindOrCreatePlaylist(GARBAGE_PLAYLIST, true);

    // Store generation state so the on_playlist_items_added callback can
    // write random tags once foobar has finished reading the new entries.
    g_gen_gc_pl      = gc_pl;
    g_gen_prev_count = plman.GetPlaylistItemCount(gc_pl);
    g_gen_expected   = paths.length;
    g_gen_paths      = paths;

    g_busy = true; g_status = "step"; window.Repaint();

    plman.AddLocations(gc_pl, paths, false);
    // → on_playlist_items_added will fire when complete; see handler below.
}


// ── Callback: fired when AddLocations finishes ────────────────────────────────

function on_playlist_items_added(playlistIndex) {
    if (g_gen_gc_pl < 0 || playlistIndex !== g_gen_gc_pl) return;

    var current_count = plman.GetPlaylistItemCount(playlistIndex);
    var added_so_far  = current_count - g_gen_prev_count;

    // AddLocations may fire the callback in batches; wait until all expected
    // items have landed.
    if (added_so_far < g_gen_expected) return;

    // All items are in the playlist.  Get handles for the newly added ones.
    var all = plman.GetPlaylistItems(playlistIndex);
    var new_handles = all.Clone();
    all.Dispose();
    // Keep only the newly added items (from prev_count onwards)
    if (g_gen_prev_count > 0) new_handles.RemoveFromIdx(0, g_gen_prev_count);
    if (new_handles.Count > g_gen_expected) new_handles.RemoveFromIdx(g_gen_expected, new_handles.Count - g_gen_expected);

    // Build a tag array with random title/artist/album for each copy.
    // Randomised tags ensure foobar treats each file as a unique library entry
    // and does not attempt to auto-transfer stats from a similarly-named track.
    var tag_arr = [];
    for (var i = 0; i < new_handles.Count; i++) {
        tag_arr.push({
            "TITLE"  : [_randomHex(16)],
            "ARTIST" : [_randomHex(16)],
            "ALBUM"  : [_randomHex(16)]
        });
    }

    try { new_handles.UpdateFileInfoFromJSON(JSON.stringify(tag_arr)); }
    catch (e) {
        new_handles.Dispose();
        g_gen_gc_pl = -1; g_gen_paths = null;
        g_busy = false; g_status = "err"; window.Repaint();
        utils.ShowPopupMessage("Failed to write randomised tags:\n" + e.message,
            "Regenerate GC Tracks \u2013 Tag Error");
        return;
    }

    new_handles.Dispose();
    g_gen_gc_pl = -1; g_gen_paths = null;
    g_busy = false; g_status = "ok"; window.Repaint();

    if (g_post_regen_cb) {
        var cb = g_post_regen_cb;
        g_post_regen_cb = null;
        cb();
    } else {
        utils.ShowPopupMessage(
            "Generated " + g_gen_expected + " GC track(s) in:\n" + g_gc_folder
            + "\n\nAdded to playlist \u201c" + GARBAGE_PLAYLIST + "\u201d.",
            "Regenerate GC Tracks \u2013 Done");
    }
}



// ── Auto-regenerate helper ────────────────────────────────────────────────────
//
//  When GC_AUTO_REGEN is enabled, regenerate GC tracks before every operation.
//  Generation is async (AddLocations + on_playlist_items_added), so we store the
//  callback to invoke once generation is complete.

var g_post_regen_cb = null;   // function to call after auto-regen finishes

function _autoRegenThen(callback) {
    if (!g_gc_auto_regen) {
        callback();
        return;
    }
    // Force clean mode when auto-regen is on
    var saved_clean = g_gc_clean;
    g_gc_clean = true;
    g_post_regen_cb = function () {
        g_gc_clean = saved_clean;
        callback();
    };
    RunGenerateGC();
}

// ════════════════════════════════════════════════════════════════════════════
//  BUTTON 1 – TRANSFER STATISTICS
// ════════════════════════════════════════════════════════════════════════════

function RunTransfer() {
    if (g_busy) return;
    _autoRegenThen(function () { _RunTransfer(); });
}
function _RunTransfer() {
    var s = _setupTransfer("Stats Transfer");
    if (!s) return;
    var tgt = s.tgt, gc_sub = s.gc_sub, tgt_stats = s.tgt_stats, n = s.n;

    var raw;
    try {
        raw = utils.TextBox(
            g_per_track
                ? "Per-track mode \u2013 " + n + " track" + (n > 1 ? "s" : "") + ". Blocks separated by --- lines."
                : "All-tracks mode \u2013 same values applied to " + n + " track" + (n > 1 ? "s" : "")
                  + ". Blank = keep current value.",
            "Stats Transfer",
            g_per_track ? buildPerTrackText(tgt) : buildAllText(tgt),
            HELP_TEXT);
    } catch (e) { gc_sub.Dispose(); tgt.Dispose(); g_status = "err"; window.Repaint(); return; }

    var parsed;
    try { parsed = parseTextBoxResult(raw, g_per_track, n); }
    catch (e) { gc_sub.Dispose(); tgt.Dispose(); utils.ShowPopupMessage(e.message, "Stats Transfer \u2013 Parse Error"); return; }

    for (var vi = 0; vi < parsed.length; vi++) {
        try { validateBlock(parsed[vi], g_per_track ? "Track " + (vi+1) + ": " : ""); }
        catch (e) { gc_sub.Dispose(); tgt.Dispose(); utils.ShowPopupMessage(e.message, "Stats Transfer \u2013 Validation Error"); return; }
    }

    var resolved = [], tag_arr = [];
    for (var j = 0; j < n; j++) {
        var b = g_per_track ? parsed[j] : parsed[0], sts = tgt_stats[j], t = {};
        var pc_val  = resolvePlayCount(b.play_count, sts.play_count);
        var rat_val = resolveRating(b.rating, sts.rating);  // always non-null; "0" for unrated
        var add_d   = resolveDate(b.added,        sts.added);
        var fp_d    = resolveDate(b.first_played, sts.first_played);
        var lp_d    = resolveDate(b.last_played,  sts.last_played);
        if (pc_val !== null) t["PLAY_COUNT"]             = [pc_val];
        t["RATING"]                                      = [rat_val];  // always write; "0" = unrated
        if (add_d)           t["ADDED_TIMESTAMP"]        = [dateToFiletime(add_d)];
        if (fp_d)            t["FIRST_PLAYED_TIMESTAMP"] = [dateToFiletime(fp_d)];
        if (lp_d)            t["LAST_PLAYED_TIMESTAMP"]  = [dateToFiletime(lp_d)];
        tag_arr.push(t);
        resolved.push({
            rating_unset : (rat_val === null),
            added_ts     : add_d ? Math.floor(add_d.getTime()/1000) : 0,
            fp_ts        : fp_d  ? Math.floor(fp_d.getTime()/1000)  : 0,
            lp_ts        : lp_d  ? Math.floor(lp_d.getTime()/1000)  : 0
        });
    }

    var cw = checkGCContamination(gc_sub, resolved, n);
    if (cw.length > 0) {
        gc_sub.Dispose(); tgt.Dispose();
        utils.ShowPopupMessage(
            "The following GC tracks have leftover foo_playcount values that\n"
            + "would be incorrectly applied to target tracks:\n\n"
            + cw.join("\n") + "\n\n"
            + "Select all tracks in \u201c" + GARBAGE_PLAYLIST + "\u201d and run\n"
            + "Playback Statistics \u2192 Reset statistics, then try again.\n"
            + "(Or use the \u21ba button next to the Regenerate button.)",
            "Stats Transfer \u2013 GC Contamination");
        return;
    }

    if (g_warn_added_reset) {
        var aw = checkAddedResetWarnings(resolved, n);
        if (aw.length > 0) {
            utils.ShowPopupMessage(
                "foo_playcount will automatically adjust %added% on the following track(s)\n"
                + "because the imported ADDED date is more recent than FIRST/LAST_PLAYED:\n\n"
                + aw.join("\n") + "\n\n"
                + "This is intentional behaviour in foo_playcount v3.1.9+.\n"
                + "The import will proceed.  Disable this warning via WARN_ADDED_RESET=false in \u2699 Settings.",
                "Stats Transfer \u2013 %added% Auto-Reset Notice");
        }
    }

    _runChain(gc_sub, tgt, tag_arr, n);
}


// ════════════════════════════════════════════════════════════════════════════
//  BUTTON 2 – MARK AS PLAYED
// ════════════════════════════════════════════════════════════════════════════

function RunMarkAsPlayed() {
    if (g_busy) return;
    _autoRegenThen(function () { _RunMarkAsPlayed(); });
}
function _RunMarkAsPlayed() {
    var s = _setupTransfer("Mark as Played");
    if (!s) return;
    var tgt = s.tgt, gc_sub = s.gc_sub, tgt_stats = s.tgt_stats, n = s.n;

    // Base "now" timestamp (seconds).  In natural mode each successive track
    // gets a last_played offset by the cumulative duration of previous tracks,
    // so timestamps may land slightly in the future.
    var now_ts   = Math.floor(Date.now() / 1000);
    var cursor   = now_ts;   // advances in natural mode

    var resolved = [], tag_arr = [];
    for (var j = 0; j < n; j++) {
        var sts = tgt_stats[j], t = {}, new_pc = sts.play_count + 1;

        // Determine the last_played timestamp for this track
        var lp_now = cursor;
        if (g_mark_natural && j < n - 1) {
            // Advance cursor by this track's duration for the next track
            var dur_str = TFO_DUR.EvalWithMetadb(tgt.GetItem(j));
            var dur_sec = parseFloat(dur_str) || 0;
            cursor += Math.ceil(dur_sec);
        }

        t["PLAY_COUNT"] = [String(new_pc)];
        // Rating: only write tag if target has a rating set (including explicit 0).
        // If target is unset (-1), leave tag absent and let contamination check
        // catch any leftover GC rating that would bleed through.
        var rat_val_map = sts.rating >= 0 ? String(sts.rating) : null;
        if (rat_val_map !== null) t["RATING"] = [rat_val_map];
        if (sts.added > 0)  t["ADDED_TIMESTAMP"] = [dateToFiletime(new Date(sts.added * 1000))];

        // LAST_PLAYED: always stamp with lp_now
        t["LAST_PLAYED_TIMESTAMP"] = [dateToFiletime(new Date(lp_now * 1000))];

        // FIRST_PLAYED: keep existing if present, otherwise stamp with lp_now
        var fp_ts = sts.first_played > 0 ? sts.first_played : lp_now;
        t["FIRST_PLAYED_TIMESTAMP"] = [dateToFiletime(new Date(fp_ts * 1000))];

        tag_arr.push(t);
        resolved.push({
            rating_unset : (rat_val_map === null),
            added_ts     : sts.added,
            fp_ts        : fp_ts,
            lp_ts        : lp_now
        });
    }

    var cw = checkGCContamination(gc_sub, resolved, n);
    if (cw.length > 0) {
        gc_sub.Dispose(); tgt.Dispose();
        utils.ShowPopupMessage(
            "The following GC tracks have leftover foo_playcount values that\n"
            + "would be incorrectly applied to target tracks:\n\n"
            + cw.join("\n") + "\n\n"
            + "Select all tracks in \u201c" + GARBAGE_PLAYLIST + "\u201d and run\n"
            + "Playback Statistics \u2192 Reset statistics, then try again.\n"
            + "(Or use the \u21ba button next to the Regenerate button.)",
            "Mark as Played \u2013 GC Contamination");
        return;
    }

    if (g_warn_added_reset) {
        var aw = checkAddedResetWarnings(resolved, n);
        if (aw.length > 0) {
            utils.ShowPopupMessage(
                "foo_playcount will automatically adjust %added% on the following track(s)\n"
                + "because the imported ADDED date is more recent than FIRST/LAST_PLAYED:\n\n"
                + aw.join("\n") + "\n\n"
                + "This is intentional behaviour in foo_playcount v3.1.9+.\n"
                + "The import will proceed.  Disable this warning via WARN_ADDED_RESET=false in \u2699 Settings.",
                "Mark as Played \u2013 %added% Auto-Reset Notice");
        }
    }

    _runChain(gc_sub, tgt, tag_arr, n);
}



// ── Reset GC playlist statistics ─────────────────────────────────────────────

function RunResetGC() {
    if (g_busy) return;
    var gc_pl = plman.FindPlaylist(GARBAGE_PLAYLIST);
    if (gc_pl < 0) {
        utils.ShowPopupMessage('Playlist "' + GARBAGE_PLAYLIST + '" not found.',
            "Reset GC Stats");
        return;
    }
    var gc_count = plman.GetPlaylistItemCount(gc_pl);
    if (gc_count === 0) {
        utils.ShowPopupMessage('Playlist "' + GARBAGE_PLAYLIST + '" is empty.',
            "Reset GC Stats");
        return;
    }
    // Select all tracks in the GC playlist, then run Reset statistics.
    // This triggers a single confirmation dialog for the whole batch.
    plman.SetPlaylistSelection(gc_pl, Array.apply(null, Array(gc_count)).map(function(_, i){ return i; }), true);
    var all = plman.GetPlaylistItems(gc_pl);
    all.RunContextCommand(CMDS.reset);
    all.Dispose();
}


// ── Open GC folder in Explorer ────────────────────────────────────────────────

function RunOpenGCFolder() {
    if (!g_gc_folder) {
        utils.ShowPopupMessage("No GC folder configured.\n" +
            "Open ⚙ Settings to set one.",
            "Open GC Folder");
        return;
    }
    if (!utils.IsFolder(g_gc_folder)) {
        utils.ShowPopupMessage("GC folder not found:\n" + g_gc_folder,
            "Open GC Folder");
        return;
    }
    utils.Run("explorer", '"' + g_gc_folder + '"');
}

// ════════════════════════════════════════════════════════════════════════════
//  PAINT & INPUT
// ════════════════════════════════════════════════════════════════════════════

function on_size() { window.Repaint(); }

function on_paint(gr) {
    var W = window.Width, H = window.Height;
    gr.FillRectangle(0, 0, W, H, C.bg);

    if (g_compact) {
        _paintCompact(gr, W, H);
    } else {
        _paintNormal(gr, W, H);
    }

    gr.FillRectangle(0, H - BAR_H, W, BAR_H, _statusColour());
}

function _paintNormal(gr, W, H) {
    var br  = _btnRect(), br2 = _btn2Rect(), br3 = _btn3Rect();
    var clr = _cleanRect(), rsr = _resetRect(), ofr = _openfldRect();
    var tr  = _togRect(), hr  = _helpRect(),  cr  = _cogRect();

    // Button 1 – Transfer
    var b1f = g_busy ? C.btn_busy : (g_btn_hover ? C.btn_hover : C.btn_idle);
    gr.FillRectangle(br.x, br.y, br.w, br.h, b1f);
    gr.DrawRectangle(br.x, br.y, br.w, br.h, 1, C.btn_border);
    gr.WriteText(g_busy ? "Working..." : "Import Playback Statistics",
        FONT_BTN, g_busy ? C.text_busy : C.text,
        br.x + 8, br.y, br.w - 16, br.h, 2, 2, 1, 0);

    // Button 2 – Mark as Played
    var b2f = g_busy ? C.btn_busy : (g_btn2_hover ? C.btn2_hover : C.btn2_idle);
    gr.FillRectangle(br2.x, br2.y, br2.w, br2.h, b2f);
    gr.DrawRectangle(br2.x, br2.y, br2.w, br2.h, 1, C.btn2_border);
    gr.WriteText(g_busy ? "" : "+1 Play Count (Mark as Played)",
        FONT_SM, g_busy ? C.text_busy : C.text2,
        br2.x + 8, br2.y, br2.w - 16, br2.h, 2, 2, 1, 0);

    // Button 3 – Regenerate GC Tracks
    var b3f = g_busy ? C.btn_busy : (g_btn3_hover ? C.btn3_hover : C.btn3_idle);
    gr.FillRectangle(br3.x, br3.y, br3.w, br3.h, b3f);
    gr.DrawRectangle(br3.x, br3.y, br3.w, br3.h, 1, C.btn3_border);
    gr.WriteText(g_busy ? "" : "Regenerate " + g_gc_count + " GC Tracks" + (g_gc_clean ? "  [\u267b clean]" : "  [+ append]"),
        FONT_SM, g_busy ? C.text_busy : C.text3,
        br3.x + 8, br3.y, br3.w - 16, br3.h, 2, 2, 1, 0);

    // Clean-toggle icon [♻] / [+]
    gr.FillRectangle(clr.x, clr.y, clr.w, clr.h, g_gc_clean ? C.tog_on : (g_clean_hover ? C.icon_hover : C.icon_idle));
    gr.DrawRectangle(clr.x, clr.y, clr.w, clr.h, 1, g_gc_clean ? C.btn3_border : C.icon_border);
    gr.WriteText(g_gc_clean ? "\u267b" : "+", FONT_ICON, g_gc_clean ? C.text3 : C.icon_text,
        clr.x, clr.y, clr.w, clr.h, 2, 2, 1, 0);

    // Reset GC stats icon [↺]
    gr.FillRectangle(rsr.x, rsr.y, rsr.w, rsr.h, g_reset_hover ? C.icon_hover : C.icon_idle);
    gr.DrawRectangle(rsr.x, rsr.y, rsr.w, rsr.h, 1, C.icon_border);
    gr.WriteText("\u21ba", FONT_ICON, C.icon_text, rsr.x, rsr.y, rsr.w, rsr.h, 2, 2, 1, 0);

    // Open GC folder icon
    gr.FillRectangle(ofr.x, ofr.y, ofr.w, ofr.h, g_openfld_hover ? C.icon_hover : C.icon_idle);
    gr.DrawRectangle(ofr.x, ofr.y, ofr.w, ofr.h, 1, C.icon_border);
    gr.WriteText("\uD83D\uDDC1", FONT_ICON, C.icon_text, ofr.x, ofr.y, ofr.w, ofr.h, 2, 2, 1, 0);

    // Toggle row
    var tf = g_per_track ? C.tog_on : (g_tog_hover ? C.tog_hover : C.tog_off);
    gr.FillRectangle(tr.x, tr.y, tr.w, tr.h, tf);
    gr.DrawRectangle(tr.x, tr.y, tr.w, tr.h, 1, C.tog_border);
    gr.WriteText(g_per_track ? "[ \u2022 ]  Per-track mode" : "[   ]  All-tracks mode",
        FONT_SM, g_per_track ? C.tog_on_txt : C.tog_text,
        tr.x + 6, tr.y, tr.w - 12, tr.h, 0, 2, 1, 0);

    // Help [?]
    gr.FillRectangle(hr.x, hr.y, hr.w, hr.h, g_help_hover ? C.icon_hover : C.icon_idle);
    gr.DrawRectangle(hr.x, hr.y, hr.w, hr.h, 1, C.icon_border);
    gr.WriteText("?", FONT_ICON, C.icon_text, hr.x, hr.y, hr.w, hr.h, 2, 2, 1, 0);

    // Cog [⚙]
    gr.FillRectangle(cr.x, cr.y, cr.w, cr.h, g_cog_hover ? C.icon_hover : C.icon_idle);
    gr.DrawRectangle(cr.x, cr.y, cr.w, cr.h, 1, C.icon_border);
    gr.WriteText("\u2699", FONT_ICON, C.icon_text, cr.x, cr.y, cr.w, cr.h, 2, 2, 1, 0);
}

function _paintCompact(gr, W, H) {
    var ir = _cImportRect(), pr = _cPlayRect(), mr = _cMoreRect();

    // Import button – ⬇
    var b1f = g_busy ? C.btn_busy : (g_btn_hover ? C.btn_hover : C.btn_idle);
    gr.FillRectangle(ir.x, ir.y, ir.w, ir.h, b1f);
    gr.DrawRectangle(ir.x, ir.y, ir.w, ir.h, 1, C.btn_border);
    gr.WriteText(g_busy ? "\u23f3" : "\u2B07", FONT_ICON_LG,
        g_busy ? C.text_busy : C.text, ir.x, ir.y, ir.w, ir.h, 2, 2, 1, 0);

    // +1 button
    var b2f = g_busy ? C.btn_busy : (g_btn2_hover ? C.btn2_hover : C.btn2_idle);
    gr.FillRectangle(pr.x, pr.y, pr.w, pr.h, b2f);
    gr.DrawRectangle(pr.x, pr.y, pr.w, pr.h, 1, C.btn2_border);
    gr.WriteText("+1", FONT_SM, g_busy ? C.text_busy : C.text2,
        pr.x, pr.y, pr.w, pr.h, 2, 2, 1, 0);

    // ... button
    var b3f = g_busy ? C.btn_busy : (g_btn3_hover ? C.icon_hover : C.icon_idle);
    gr.FillRectangle(mr.x, mr.y, mr.w, mr.h, b3f);
    gr.DrawRectangle(mr.x, mr.y, mr.w, mr.h, 1, C.icon_border);
    gr.WriteText("...", FONT_SM, C.icon_text, mr.x, mr.y, mr.w, mr.h, 2, 2, 1, 0);
}

function on_mouse_move(x, y) {
    if (g_compact) { _mouseMoveCompact(x, y); return; }
    var bh   = !g_busy && _inRect(_btnRect(),    x, y);
    var bh2  = !g_busy && _inRect(_btn2Rect(),   x, y);
    var bh3  = !g_busy && _inRect(_btn3Rect(),   x, y);
    var clh  = !g_busy && _inRect(_cleanRect(),  x, y);
    var rsh  = !g_busy && _inRect(_resetRect(),  x, y);
    var ofh  = !g_busy && _inRect(_openfldRect(),x, y);
    var th   = !g_busy && _inRect(_togRect(),    x, y);
    var hh   = !g_busy && _inRect(_helpRect(),   x, y);
    var ch   = !g_busy && _inRect(_cogRect(),    x, y);
    if (bh  !== g_btn_hover   || bh2 !== g_btn2_hover || bh3 !== g_btn3_hover
     || clh !== g_clean_hover || rsh !== g_reset_hover || ofh !== g_openfld_hover
     || th  !== g_tog_hover   || hh  !== g_help_hover  || ch  !== g_cog_hover) {
        g_btn_hover = bh; g_btn2_hover = bh2; g_btn3_hover = bh3;
        g_clean_hover = clh; g_reset_hover = rsh; g_openfld_hover = ofh;
        g_tog_hover = th; g_help_hover = hh; g_cog_hover = ch;
        window.Repaint();
    }
    var tip = bh  ? TOOLTIP.btn1
            : clh ? TOOLTIP.clean
            : rsh ? TOOLTIP.reset
            : ofh ? TOOLTIP.openfld
            : hh  ? TOOLTIP.help
            : ch  ? TOOLTIP.cog
            :       "";
    if (tip) {
        if (g_tooltip.Text !== tip) { g_tooltip.Text = tip; g_tooltip.Activate(); }
    } else {
        g_tooltip.Deactivate();
    }
}

function _mouseMoveCompact(x, y) {
    var bh  = !g_busy && _inRect(_cImportRect(), x, y);
    var bh2 = !g_busy && _inRect(_cPlayRect(),   x, y);
    var bh3 = !g_busy && _inRect(_cMoreRect(),   x, y);
    if (bh !== g_btn_hover || bh2 !== g_btn2_hover || bh3 !== g_btn3_hover) {
        g_btn_hover = bh; g_btn2_hover = bh2; g_btn3_hover = bh3;
        window.Repaint();
    }
    var tip = bh ? TOOLTIP.btn1 : "";
    if (tip) {
        if (g_tooltip.Text !== tip) { g_tooltip.Text = tip; g_tooltip.Activate(); }
    } else {
        g_tooltip.Deactivate();
    }
}

function on_mouse_leave() {
    g_btn_hover = false; g_btn2_hover = false; g_btn3_hover = false;
    g_clean_hover = false; g_reset_hover = false; g_openfld_hover = false;
    g_tog_hover = false; g_help_hover = false; g_cog_hover = false;
    window.Repaint();
    g_tooltip.Deactivate();
}

function on_mouse_lbtn_up(x, y) {
    if (g_busy) return;
    if (g_compact) { _lbtnUpCompact(x, y); return; }
    if      (_inRect(_btnRect(),     x, y)) RunTransfer();
    else if (_inRect(_btn2Rect(),    x, y)) RunMarkAsPlayed();
    else if (_inRect(_btn3Rect(),    x, y)) RunGenerateGC();
    else if (_inRect(_cleanRect(),   x, y)) {
        g_gc_clean = !g_gc_clean;
        window.SetProperty("gc_clean", g_gc_clean);
        window.Repaint();
    }
    else if (_inRect(_resetRect(),   x, y)) RunResetGC();
    else if (_inRect(_openfldRect(), x, y)) RunOpenGCFolder();
    else if (_inRect(_togRect(),     x, y)) {
        g_per_track = !g_per_track;
        window.SetProperty("per_track_mode", g_per_track);
        window.Repaint();
    }
    else if (_inRect(_helpRect(), x, y)) utils.ShowPopupMessage(HELP_TEXT, "Stats Transfer \u2013 Help");
    else if (_inRect(_cogRect(),  x, y)) showSettings();
}

function _lbtnUpCompact(x, y) {
    if      (_inRect(_cImportRect(), x, y)) RunTransfer();
    else if (_inRect(_cPlayRect(),   x, y)) RunMarkAsPlayed();
    else if (_inRect(_cMoreRect(),   x, y)) _showCompactMenu(x, y);
}

// Native OS floating context menu for compact mode "..." button.
// Uses window.CreatePopupMenu() which renders outside panel bounds.
function _showCompactMenu(x, y) {
    var items = _menuItems();
    var menu  = window.CreatePopupMenu();
    for (var i = 0; i < items.length; i++) {
        if (items[i].type === "sep") {
            menu.AppendMenuSeparator();
        } else {
            var lbl = items[i].stateLabel ? items[i].stateLabel() : items[i].label;
            menu.AppendMenuItem(MF_STRING, i + 1, lbl);
        }
    }
    var idx = menu.TrackPopupMenu(x, y);
    menu.Dispose();
    if (idx > 0) {
        items[idx - 1].action();
        window.Repaint();
    }
}

function on_mouse_rbtn_up(x, y) {
    // In compact mode, right-click anywhere also opens the "..." menu
    if (g_compact && !g_busy) { _showCompactMenu(x, y); return true; }
    return false;
}