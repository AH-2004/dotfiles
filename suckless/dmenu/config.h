// See LICENSE file for copyright and license details.
// Default settings; can be overriden by command line.

static int topbar = 0; // -b option;
static const char *fonts[] = { "IBM Plex Mono:size=9" }; // -fn option;
static const char *prompt = NULL; // -p  option;
static unsigned int lines = 0; // -l option; if nonzero, dmenu uses vertical

// Colors
static const char col_white[] = "#ffffff";
static const char col_black[] = "#000000";
static const char col_gray[] = "#1d1f21";
static const char col_gray2[] = "#b9b4b0";
static const char col_accent[] = "#005254";

static const char *colors[SchemeLast][2] = {
    // fg, bg
    [SchemeNorm] = { col_gray2, col_gray },
    [SchemeSel] = { col_gray, col_accent },
	[SchemeSelHighlight] = { col_white, col_accent },
	[SchemeNormHighlight] = { col_white, col_gray },
    [SchemeOut] = { col_black, col_accent }
};

// Chars not considered part of a word while deleting words, for example: " /?\"&[]"
static const char worddelimiters[] = " ";
