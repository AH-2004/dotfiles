// See LICENSE file for copyright and license details.

// Appearance
static const unsigned int borderpx = 1;
static const unsigned int snap = 16;
static const int showbar = 1;
static const int topbar = 0;
static const int splitstatus = 1;
static const char *splitdelim = ";"; 
static const int showsystray = 1; 
static const unsigned int systraypinning = -1; // 0: Selected monitor, < 0: Display
static const unsigned int systrayonleft = 0;
static const unsigned int systrayspacing = 6;
static const unsigned int systrayiconsize = 14;
static const int systraypinningfailfirst = 1; // 1: First monitor, 0: Last Monitor
static const char *selmonsymbol = "*"; 

// Fonts
static const char *fonts[] = { "IBM Plex Mono:size=9", "Material Icons:size=9" };
static const char dmenufont[] = "IBM Plex Mono:size=9";

// Colors
// static const char col_gray1[] = "#1d1f21";
static const char col_gray1[] = "#080808";
static const char col_gray2[] = "#444444";
static const char col_gray3[] = "#bbbbbb";
static const char col_gray4[] = "#eeeeee";
/* static const char col_accent[] = "#b294bb"; */
static const char col_accent[] = "#005254";

static const char *colors[][3] = {
	// { fg, bg, border }
	[SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
	[SchemeSel]  = { col_gray4, col_accent, col_gray3 }
};

// Others
static const int focusonwheel = 1;
static const int raiseonfocus = 1;
static const int tagonswap = 0;
static const int startwithgaps[] = { 1 }; // 1: gaps by default, can be customized per tag
static const unsigned int gappx[] = { 12 }; // default gap in px, can be customized per tag
static const unsigned int tabModKey = XK_Alt_L;
static const unsigned int tabKey = XK_Tab;
static const char *logfilename = "dwm.log";

// Tagging
static char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };
static const Rule rules[] = {
	// { class, instance, title, tags mask, isfloating, monitor, isfakefullscreen, unmanaged }
	{ NULL, NULL, NULL, 0, 1, -1, 0, 0 },
	{ "Vivaldi-stable", NULL,  NULL, 0, 0, -1, 1, 0 },
	{ "Emacs", NULL, NULL, 0, 0, -1, 0, 0 },
	{ "Zathura", NULL, NULL, 0, 0, -1, 0, 0 },
	{ "Com.github.xournalpp.xournalpp", NULL, NULL, 0, 0, -1, 0, 0 },
	{ "Plank", NULL, NULL, 0, 0, -1, 0, 1 },
	{ "rocketleague.exe", NULL, NULL, 0, 0, 0, 0, 0 }
};

static const float mfact = 0.55; // Factor of master area size
static const float mfactmargin = 0.05; // Margin of master area size
static const int nmaster = 1;// Number of clients in master area
static const int resizehints = 0; // 1 means respect size hints in tiled resizals
static const int lockfullscreen = 1; // Force lock fullscreen
static const int statuspinning = 0;
static const Layout layouts[] = {
	// { symbol, arrange function }
	// First index is default, NULL means floating
	{ "Tile", tile },
	{ "Float", NULL },
	{ "Column", column },
	{ "Row", row },
	{ "[M]", monocle }
};

// Definitions
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY, KEY, view, {.ui = 1 << TAG} }, \
	{ Mod1Mask|ShiftMask, KEY, swaptags, {.ui = 1 << TAG} },	\
	{ MODKEY|Mod1Mask|ShiftMask, KEY, swaptags, {.ui = 1 << TAG} },	\
	{ MODKEY|ShiftMask, KEY, tag, {.ui = 1 << TAG} }, \

// Helper for spawning shell commands in the pre dwm-5.0 fashion
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }
#define SCRIPTS_PATH "/home/AH/.config/scripts"
#define BASH_FUNCTIONS "/home/AH/.bash_functions"
static char dmenumon[2] = "0"; // Component of dmenucmd, manipulated in spawn()

// Commands
static const char *dmenucmd[] = { "j4-dmenu-desktop", "--dmenu=dmenu", "--no-generic", NULL };
static const char *clipmenucmd[] = { "clipmenu", NULL };
static const char *terminalcmd[] = { "st", NULL };
static const char *suspendcmd[] = { "systemctl", "suspend", NULL };
static const char *screenshotcmd[] = { SCRIPTS_PATH"/screenshot.sh", NULL };
static const char *emacscmd[] = { "emacsclient", "-c", "-n", NULL };
static const char *incbacklightcmd[] = { BASH_FUNCTIONS, "inc_backlight", NULL };
static const char *decbacklightcmd[] = { BASH_FUNCTIONS, "dec_backlight", NULL };
static const char *incvolumecmd[] = { BASH_FUNCTIONS, "inc_volume", NULL };
static const char *decvolumecmd[] = { BASH_FUNCTIONS, "dec_volume", NULL };
static const char *mutevolumecmd[] = { BASH_FUNCTIONS, "mute_volume", NULL };
static const char *togglerotatecmd[] = { BASH_FUNCTIONS, "toggle_rotate", NULL };
static const char *togglenightmodecmd[] = { BASH_FUNCTIONS, "toggle_nightmode", NULL };
static const char *togglemidnightmodecmd[] = { BASH_FUNCTIONS, "toggle_midnightmode", NULL };
static const char *mediaplaypausecmd[] = { BASH_FUNCTIONS, "media_playpause", NULL };
static const char *medianextcmd[] = { BASH_FUNCTIONS, "media_next", NULL };
static const char *mediapreviouscmd[] = { BASH_FUNCTIONS, "media_previous", NULL };
static const char *toggleblankcmd[] = { BASH_FUNCTIONS, "toggle_blank", NULL };
static const char *togglescrollcmd[] = { BASH_FUNCTIONS, "toggle_scroll", NULL };
static const char *rotationcmd[] = { SCRIPTS_PATH"/rotation.sh", NULL };
static const char *customcmd[] = { SCRIPTS_PATH"/custom_key.sh", NULL };

// Keys and Buttons
static const Key keys[] = {
    // { modifier, key, function, argument }
    { 0, XK_Print, spawn, {.v = screenshotcmd} },
    { 0, XF86XK_MonBrightnessUp, spawn, {.v = incbacklightcmd} },
    { 0, XF86XK_MonBrightnessDown, spawn, {.v = decbacklightcmd} },
    { 0, XF86XK_AudioRaiseVolume, spawn, {.v = incvolumecmd} },
    { 0, XF86XK_AudioLowerVolume, spawn, {.v = decvolumecmd} },
    { 0, XF86XK_AudioMute, spawn, {.v = mutevolumecmd} },
    { 0, XF86XK_AudioPlay, spawn, {.v = mediaplaypausecmd} },
    { 0, XF86XK_AudioNext, spawn, {.v = medianextcmd} },
    { 0, XF86XK_AudioPrev, spawn, {.v = mediapreviouscmd} },
	{ 0, XF86XK_Favorites, spawn, {.v = customcmd} },
	{ 0, XF86XK_Display, spawn, {.v = togglerotatecmd} },
	{ 0, XF86XK_Tools, spawn, {.v = togglenightmodecmd} },
	{ 0, XF86XK_RotateWindows, spawn, {.v = rotationcmd} },
	{ 0, XF86XK_ScreenSaver, spawn, {.v = suspendcmd} },
	{ ShiftMask, XF86XK_Tools, spawn, {.v = togglemidnightmodecmd} },
    { Mod1Mask, XK_space, spawn, {.v = dmenucmd} },
    { Mod1Mask|ShiftMask, XK_space, spawn, {.v = clipmenucmd} },
    { Mod1Mask|ControlMask, XK_t, spawn, {.v = terminalcmd} },
    { Mod1Mask|ControlMask, XK_e, spawn, {.v = emacscmd} },
    { MODKEY, XK_l, spawn, {.v = suspendcmd} },
    { MODKEY, XK_d, spawn, {.v = toggleblankcmd} },
    { MODKEY, XK_b, togglebar, {0} },
	{ MODKEY, XK_w, toggleborder, {0} },
	{ MODKEY, XK_Left, setmfact, {.f = -0.05} },
    { MODKEY, XK_Right, setmfact, {.f = +0.05} },
    { MODKEY, XK_Return, zoom, {0} },
    { MODKEY, XK_space, zoom, {0} },
    { MODKEY, XK_x, killclient, {0} },
    { MODKEY, XK_t, setlayout, {.v = &layouts[0]} },
    { MODKEY, XK_f, setlayout, {.v = &layouts[1]} },
    { MODKEY, XK_c, setlayout, {.v = &layouts[2]} },
    { MODKEY, XK_r, setlayout, {.v = &layouts[3]} },
    { MODKEY, XK_Up, focusmon, {.i = -1} },
    { MODKEY, XK_Down, focusmon, {.i = +1} },
    { MODKEY, XK_0, setgaps, {.i = GAP_RESET } },
	{ MODKEY, XK_minus, setgaps, {.i = -3} },
    { MODKEY, XK_equal, setgaps, {.i = +3} },
	{ MODKEY, XK_i, toggleimmersive, {0} },
    { MODKEY|ShiftMask, XK_equal, incnmaster, {.i = +1} },
    { MODKEY|ShiftMask, XK_minus, incnmaster, {.i = -1} },
    { MODKEY|ShiftMask, XK_space, togglefloating, {0} },
    { MODKEY|ShiftMask, XK_Prior, shiftview, {.i = +1} },
    { MODKEY|ShiftMask, XK_Next, shiftview, {.i = -1} },
	{ MODKEY|ShiftMask, XK_Up,  tagmon, {.i = -1} },
	{ MODKEY|ShiftMask, XK_Down, tagmon, {.i = +1} },
	{ MODKEY|ShiftMask, XK_q, quit, {0} },
	{ Mod1Mask, XK_Tab, alttab, {0} },
    { MODKEY, XF86XK_AudioLowerVolume, setmfact, {.f = -0.05} },
    { MODKEY, XF86XK_AudioRaiseVolume, setmfact, {.f = +0.05} },
    { MODKEY|ShiftMask, XF86XK_AudioRaiseVolume, setgaps, {.i = -3} },
    { MODKEY|ShiftMask, XF86XK_AudioLowerVolume, setgaps, {.i = +3} },
	{ Mod1Mask, XF86XK_AudioRaiseVolume, spawn, {.v = medianextcmd} },
    { Mod1Mask, XF86XK_AudioLowerVolume, spawn, {.v = mediapreviouscmd} },
    TAGKEYS(XK_1, 0) TAGKEYS(XK_2, 1) TAGKEYS(XK_3, 2)
    TAGKEYS(XK_4, 3) TAGKEYS(XK_5, 4) TAGKEYS(XK_6, 5)
    TAGKEYS(XK_7, 6) TAGKEYS(XK_8, 7) TAGKEYS(XK_9, 8)
};

static const Button buttons[] = {
	// click:  ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, ClkRootWin
	// { click, event mask, button, function, argument }
	{ ClkLtSymbol, 0, Button1, setlayout, {0} },
	{ ClkLtSymbol, 0, Button3, setlayout, {.v = &layouts[2]} },
	{ ClkStatusText, 0, Button4, spawn, {.v = incbacklightcmd} },
	{ ClkStatusText, 0, Button5, spawn, {.v = decbacklightcmd} },
	{ ClkClientWin, Mod1Mask, Button1, movemouse, {0} },
	{ ClkClientWin, MODKEY|Mod1Mask, Button1, resizemouse, {0} },
	{ ClkClientWin, Mod1Mask, Button3, resizemouse, {0} },
	{ ClkTagBar, 0, Button1, view, {0} },
	{ ClkTagBar, MODKEY|ShiftMask, Button1, tag, {0} },
	// Assigning Scroll toggling for Button11 on every possible clickable element
	{ ClkTagBar, 0, Button11, spawn, { .v = togglescrollcmd } },
	{ ClkLtSymbol, 0, Button11, spawn, { .v = togglescrollcmd } },
	{ ClkStatusText, 0, Button11, spawn, { .v = togglescrollcmd } },
	{ ClkWinTitle, 0, Button11, spawn, { .v = togglescrollcmd } },
	{ ClkClientWin, 0, Button11, spawn, { .v = togglescrollcmd } },
	{ ClkRootWin, 0, Button11, spawn, { .v = togglescrollcmd } },
};
