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

// Fonts
static const char *fonts[] = { "IBM Plex Mono:size=9", "Material Icons:size=9" };
static const char dmenufont[] = "IBM Plex Mono:size=9";

// Colors
static const char col_gray1[] = "#1d1f21";
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

// Alt Tab
static const unsigned int tabModKey = 0x40;
static const unsigned int tabCycleKey = 0x17;
static const unsigned int tabPosY = 1; // 0: Bottom, 1: Center, 2: top
static const unsigned int tabPosX = 1; // 0: Left, 1: Center, 2: Right
static const unsigned int maxWText = 600;
static const unsigned int maxHText = 25;
static const unsigned int tabLeftPad = 5;

// Tagging
static const char *tags[] = { "1", "2", "3", "4", "5", "6" };
static const Rule rules[] = {
	// { class, instance, title, tags mask, isfloating, monitor, unmanaged }
	{ NULL, NULL, NULL, 0, 1, -1, 0 },
	{ "Vivaldi-stable", NULL,  NULL, 0, 0, -1, 0 },
	{ "Emacs", NULL, NULL, 0, 0, -1, 0 },
	{ "Zathura", NULL, NULL, 0, 0, -1, 0 },
	{ "Com.github.xournalpp.xournalpp", NULL, NULL, 0, 0, -1, 0 },
	{ "Plank", NULL, NULL, 0, 0, -1, 1 }
};

// Layouts
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
	{ "[M]", monocle }
};

// Definitions
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY, KEY, view, {.ui = 1 << TAG} }, \
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
static const char *incbacklightcmd[] = { "light", "-A", "5", NULL };
static const char *decbacklightcmd[] = { "light", "-U", "5", NULL };
static const char *incvolumecmd[] = { "pactl", "set-sink-volume", "@DEFAULT_SINK@", "+5%", NULL };
static const char *decvolumecmd[] = { "pactl", "set-sink-volume", "@DEFAULT_SINK@", "-5%", NULL };
static const char *mutevolumecmd[] = { "pactl", "set-sink-mute", "@DEFAULT_SINK@", "toggle", NULL };
static const char *togglerotatecmd[] = { BASH_FUNCTIONS, "toggle_rotate", NULL };
static const char *togglenightmodecmd[] = { BASH_FUNCTIONS, "toggle_nightmode", NULL };
static const char *togglemidnightmodecmd[] = { BASH_FUNCTIONS, "toggle_midnightmode", NULL };
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
	{ 0, XF86XK_Favorites, spawn, {.v = customcmd} },
	/* { 0, XF86XK_Launch1, spawn, {.v = } }, */
	{ 0, XF86XK_Display, spawn, {.v = togglerotatecmd} },
	{ 0, XF86XK_Tools, spawn, {.v = togglenightmodecmd} },
	{ MODKEY, XF86XK_Tools, spawn, {.v = togglemidnightmodecmd} },
    { Mod1Mask, XK_space, spawn, {.v = dmenucmd} },
    { Mod1Mask|ShiftMask, XK_space, spawn, {.v = clipmenucmd} },
    { Mod1Mask|ControlMask, XK_t, spawn, {.v = terminalcmd} },
    { Mod1Mask|ControlMask, XK_e, spawn, {.v = emacscmd} },
    { Mod1Mask, XK_Tab, altTabStart, {0} },
    { MODKEY, XK_l, spawn, {.v = suspendcmd} },
    { MODKEY, XK_b, togglebar, {0} },
	{ MODKEY, XK_w, toggleborder, {0} },
    { MODKEY, XK_Left, setmfact, {.f = -0.05} },
    { MODKEY, XK_Right, setmfact, {.f = +0.05} },
    { MODKEY, XK_Return, zoom, {0} },
    { MODKEY, XK_space, zoom, {0} },
    { MODKEY, XK_x, killclient, {0} },
    { MODKEY, XK_t, setlayout, {.v = &layouts[0]} },
    { MODKEY, XK_f, setlayout, {.v = &layouts[1]} },
    { MODKEY, XK_Up, focusmon, {.i = -1} },
    { MODKEY, XK_Down, focusmon, {.i = +1} },
    { MODKEY, XK_0, setgaps, {.i = GAP_RESET } },
    { MODKEY, XK_minus, setgaps, {.i = -3} },
    { MODKEY, XK_equal, setgaps, {.i = +3} },
    { MODKEY|ShiftMask, XK_equal, incnmaster, {.i = +1} },
    { MODKEY|ShiftMask, XK_minus, incnmaster, {.i = -1} },
    { MODKEY|ShiftMask, XK_space, togglefloating, {0} },
    { MODKEY|ShiftMask, XK_Prior, shiftview, {.i = +1} },
    { MODKEY|ShiftMask, XK_Next, shiftview, {.i = -1} },
	{ MODKEY|ShiftMask, XK_Up,  tagmon, {.i = -1 } },
	{ MODKEY|ShiftMask, XK_Down, tagmon, {.i = +1 } },
    TAGKEYS(XK_1, 0) TAGKEYS(XK_2, 1) TAGKEYS(XK_3, 2)
    TAGKEYS(XK_4, 3) TAGKEYS(XK_5, 4) TAGKEYS(XK_6, 5)
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
};
