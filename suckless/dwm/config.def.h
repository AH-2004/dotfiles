// See LICENSE file for copyright and license details.

// Appearance
static const unsigned int borderpx = 3; // border pixel of windows
static const unsigned int snap = 16; // snap pixel
static const unsigned int gappx = 6; // gap pixel between windows
static const int showbar = 1; // 0 means no bar
static const int topbar = 1; // 0 means bottom bar
static const char *fonts[] = { "IBM Plex Mono:size=10" };
static const char dmenufont[] = "IBM Plex Mono:size=10";
static const unsigned int baralpha = 0xd0;
static const unsigned int borderalpha = OPAQUE;

// Colors
static const char col_gray1[] = "#222222";
static const char col_gray2[] = "#444444";
static const char col_gray3[] = "#bbbbbb";
static const char col_gray4[] = "#eeeeee";
static const char col_magenta[] = "#bd93f9";
static const char col_teal[] = "#008080";

static const char *colors[][3] = {
	// fg, bg, border
	[SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
	[SchemeSel]  = { col_gray4, col_magenta, col_magenta }
};

static const unsigned int alphas[][3] = {
    // fg, bg, border
    [SchemeNorm] = { OPAQUE, baralpha, borderalpha },
    [SchemeSel] = { OPAQUE, baralpha, borderalpha },
};

// Tagging
static const char *tags[] = {"1", "2", "3", "4"};

static const Rule rules[] = {
	// class, instance, title, tags mask, isfloating, monitor
	{ NULL, NULL, NULL, 0, 1, -1 },
};

// Layouts
static const float mfact = 0.55; // factor of master area size [0.05..0.95]
static const int nmaster = 1; // number of clients in master area
static const int resizehints = 1; // 1 means respect size hints in tiled resizals
static const int lockfullscreen = 1; // 1 will force focus on the fullscreen window

static const Layout layouts[] = {
	// symbol, arrange function
	{ "Float", NULL }, // no layout function means floating behavior
	{ "Tile", tile }, // first entry is default
	{ "Mono", monocle }
};

// Key Definitions
#define TAGKEYS(KEY,TAG) \
	{ Mod4Mask, KEY, view, {.ui = 1 << TAG} }, \
	{ Mod4Mask|ControlMask, KEY, toggleview, {.ui = 1 << TAG} }, \
	{ Mod4Mask|ShiftMask, KEY, tag, {.ui = 1 << TAG} }, \
	{ Mod4Mask|ControlMask|ShiftMask, KEY, toggletag, {.ui = 1 << TAG} },

// helper for spawning shell commands in the pre dwm-5.0 fashion
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

// Commands
static char dmenumon[2] = "0"; // component of dmenucmd, manipulated in spawn()
static const char *dmenucmd[] = { "j4-dmenu-desktop", "--dmenu=dmenu", "--no-generic" };
static const char *termcmd[]  = { "alacritty" };

static const Key keys[] = {
	// modifier, key, function, argument
	{ Mod1Mask, XK_space, spawn, {.v = dmenucmd } },
	{ Mod1Mask|ControlMask, XK_t, spawn, {.v = termcmd } },
	{ Mod1Mask, XK_b, togglebar, {0} },
	{ Mod1Mask, XK_j, focusstack, {.i = +1 } },
	{ Mod1Mask, XK_k, focusstack, {.i = -1 } },
	{ Mod1Mask, XK_i, incnmaster, {.i = +1 } },
	{ Mod1Mask, XK_d, incnmaster, {.i = -1 } },
	{ Mod4Mask, XK_Left, setmfact, {.f = -0.05} },
	{ Mod4Mask, XK_Right, setmfact, {.f = +0.05} },
	{ Mod4Mask, XK_Return, zoom, {0} },
	{ Mod1Mask, XK_Tab, view, {0} },
	{ Mod4Mask, XK_x, killclient, {0} },
	{ Mod4Mask, XK_f, setlayout, {.v = &layouts[0]} },
	{ Mod4Mask, XK_t, setlayout, {.v = &layouts[1]} },
	{ Mod4Mask, XK_m, setlayout, {.v = &layouts[2]} },
	/* { Mod1Mask, XK_space, setlayout, {0} }, */
	{ Mod4Mask|ShiftMask, XK_space, togglefloating, {0} },
	{ Mod4Mask, XK_0, view, {.ui = ~0 } },
	{ Mod4Mask|ShiftMask, XK_0, tag, {.ui = ~0 } },
	{ Mod4Mask, XK_comma, focusmon, {.i = -1 } },
	{ Mod4Mask, XK_period, focusmon, {.i = +1 } },
	{ Mod4Mask|ShiftMask, XK_comma, tagmon, {.i = -1 } },
	{ Mod4Mask|ShiftMask, XK_period, tagmon, {.i = +1 } },
	{ Mod4Mask, XK_minus,  setgaps, {.i = -1 } },
	{ Mod4Mask, XK_equal, setgaps, {.i = +1 } },
	{ Mod4Mask|ShiftMask, XK_equal, setgaps, {.i = 0  } },
	TAGKEYS(XK_1, 0)
	TAGKEYS(XK_2, 1)
	TAGKEYS(XK_3, 2)
	TAGKEYS(XK_4, 3)
	{ Mod4Mask|ShiftMask, XK_q, quit, {0} }
};

// Button Definitions
// click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin
static const Button buttons[] = {
	// click, event mask, button, function, argument
	{ ClkLtSymbol, 0, Button1, setlayout, {0} },
	{ ClkLtSymbol, 0, Button3, setlayout, {.v = &layouts[2]} },
	{ ClkWinTitle, 0, Button2, zoom, {0} },
	{ ClkStatusText, 0, Button2, spawn, {.v = termcmd } },
	{ ClkClientWin, Mod1Mask, Button1, movemouse, {0} },
	{ ClkClientWin, Mod1Mask, Button2, togglefloating, {0} },
	{ ClkClientWin, Mod1Mask, Button3, resizemouse, {0} },
	{ ClkClientWin, Mod1Mask|Mod4Mask, Button1, resizemouse, {0} },
	{ ClkTagBar, 0, Button1, view, {0} },
	{ ClkTagBar, 0, Button3, toggleview, {0} },
	{ ClkTagBar, Mod1Mask, Button1, tag, {0} },
	{ ClkTagBar, Mod1Mask, Button3, toggletag, {0} }
};