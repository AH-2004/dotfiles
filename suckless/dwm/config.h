// See LICENSE file for copyright and license details.

// Appearance
static const unsigned int borderpx = 3;
static const unsigned int snap = 16;
static const unsigned int gappx = 12;
static const int showbar = 1;
static const int topbar = 1;
static const int splitstatus = 1;
static const char *splitdelim = ";"; 
static const int refreshrate = 60;

// Fonts
static const char *fonts[] = { "IBM Plex Mono:size=9", "Material Icons:size=10" };
static const char dmenufont[] = "IBM Plex Mono:size=9";

// Colors
static const char col_gray1[] = "#222222";
static const char col_gray2[] = "#444444";
static const char col_gray3[] = "#bbbbbb";
static const char col_gray4[] = "#eeeeee";
static const char col_magenta[] = "#bd93f9";
// static const char col_teal[] = "#008080";

static const char *colors[][3] = {
	// { fg, bg, border }
	[SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
	[SchemeSel]  = { col_gray4, col_magenta, col_magenta }
};

// Others
static const int showsystray = 1; 
static const unsigned int systraypinning = -1; // 0: Selected monitor, < 0: Display
static const unsigned int systrayonleft = 0;
static const unsigned int systrayspacing = 6;
static const unsigned int systrayiconsize = 14;
static const int systraypinningfailfirst = 1; // 1: First monitor, 0: Last Monitor
static const int focusonwheel = 1;
static const int raiseonfocus = 1;

// Alt Tab
static const unsigned int tabModKey = 0x40;
static const unsigned int tabCycleKey = 0x17;
static const unsigned int tabPosY = 1; // 0: Bottom, 1: Center, 2: top
static const unsigned int tabPosX = 1; // 0: Left, 1: Center, 2: Right
static const unsigned int maxWTab = 600;
static const unsigned int maxHTab = 150;

// Tagging
static const char *tags[] = { "1", "2", "3", "4" };
static const Rule rules[] = {
	// { class, instance, title, tags mask, isfloating, monitor, unmanaged }
	{ NULL, NULL, NULL, 0, 1, -1, 0 },
	{ "Vivaldi-stable", NULL,  NULL, 0, 0, -1, 0 },
	{ "Emacs", NULL, NULL, 0, 0, -1, 0 }
};

// Layouts
static const float mfact = 0.55; // Factor of master area size [0.05..0.95]
static const int nmaster = 1;// Number of clients in master area
static const int resizehints = 1; // 1 means respect size hints in tiled resizals
static const int lockfullscreen = 1; // Force lock fullscreen
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
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

// Helper for spawning shell commands in the pre dwm-5.0 fashion
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }
static char dmenumon[2] = "0"; // Component of dmenucmd, manipulated in spawn()

// Commands
static const char *dmenucmd[] = { "j4-dmenu-desktop", "--dmenu=dmenu", "--no-generic", NULL };
static const char *clipmenucmd[] = { "clipmenu", NULL };
static const char *termcmd[] = { "alacritty", NULL };
static const char *suspendcmd[] = { "systemctl", "suspend", NULL };
static const char *screenshotcmd[] = { "/home/AH/.config/dwm/scripts/screenshot.sh", NULL };

// Keys and Buttons
static const Key keys[] = {
    // { modifier, key, function, argument }
    {Mod1Mask, XK_space, spawn, {.v = dmenucmd}},
    {Mod1Mask | ShiftMask, XK_space, spawn, {.v = clipmenucmd}},
    {Mod1Mask | ControlMask, XK_t, spawn, {.v = termcmd}},
    {MODKEY, XK_l, spawn, {.v = suspendcmd}},
	{0, XK_Print, spawn, {.v = screenshotcmd}},
    {MODKEY, XK_b, togglebar, {0}},
    {MODKEY, XK_j, focusstack, {.i = +1}},
    {MODKEY, XK_k, focusstack, {.i = -1}},
    {MODKEY, XK_i, incnmaster, {.i = +1}},
    {MODKEY, XK_d, incnmaster, {.i = -1}},
    {MODKEY, XK_Left, setmfact, {.f = -0.05}},
    {MODKEY, XK_Right, setmfact, {.f = +0.05}},
    {MODKEY, XK_Return, zoom, {0}},
    {MODKEY, XK_x, killclient, {0}},
    {MODKEY, XK_t, setlayout, {.v = &layouts[0]}},
    {MODKEY, XK_f, setlayout, {.v = &layouts[1]}},
    {MODKEY | ShiftMask, XK_space, togglefloating, {0}},
    {MODKEY, XK_0, view, {.ui = ~0}},
    {MODKEY | ShiftMask, XK_0, tag, {.ui = ~0}},
    {MODKEY, XK_comma, focusmon, {.i = -1}},
    {MODKEY, XK_period, focusmon, {.i = +1}},
    {MODKEY | ShiftMask, XK_comma, tagmon, {.i = -3}},
    {MODKEY | ShiftMask, XK_period, tagmon, {.i = +3}},
    {MODKEY, XK_minus, setgaps, {.i = -3}},
    {MODKEY, XK_equal, setgaps, {.i = +3}},
    {Mod1Mask, XK_Tab, altTabStart, {0}},
    {MODKEY | ShiftMask, XK_q, quit, {0}},
    TAGKEYS(XK_1, 0) TAGKEYS(XK_2, 1) TAGKEYS(XK_3, 2) TAGKEYS(XK_4, 3)};

static const Button buttons[] = {
	// click:  ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, ClkRootWin
	// { click, event mask, button, function, argument }
	{ ClkLtSymbol, 0, Button1, setlayout, {0} },
	{ ClkLtSymbol, 0, Button3, setlayout, {.v = &layouts[2]} },
	{ ClkWinTitle, 0, Button2, zoom, {0} },
	{ ClkStatusText, 0, Button2, spawn, {.v = termcmd } },
	{ ClkClientWin, Mod1Mask, Button1, movemouse, {0} },
	{ ClkClientWin, Mod1Mask, Button2, togglefloating, {0} },
	{ ClkClientWin, Mod1Mask, Button3, resizemouse, {0} },
	{ ClkClientWin, MODKEY|Mod1Mask, Button1, resizemouse, {0} },
	{ ClkTagBar, 0, Button1, view, {0} },
	{ ClkTagBar, 0, Button3, toggleview, {0} },
	{ ClkTagBar, Mod1Mask, Button1, tag, {0} },
	{ ClkTagBar, Mod1Mask, Button3, toggletag, {0} }
};