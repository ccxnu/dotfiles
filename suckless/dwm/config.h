/* =====================================
  @author: Pablo Cuenca
  @url: https://github.com/ccxnu
===================================== */

/*  Constants */
#define TERMINAL "st"
#define TERMCLASS "St"
#define BROWSER "Floorp"

/*  Appearance */
static const unsigned int borderpx  = 1; /* border pixel of windows and border or screen */
static const unsigned int snap      = 0; /* snap pixel */
static const unsigned int gappih    = 0; /* horiz inner gap between windows */
static const unsigned int gappiv    = 0; /* vert inner gap between windows */
static const unsigned int gappoh    = 0; /* horiz outer gap between windows and screen edge */
static const unsigned int gappov    = 0; /* vert outer gap between windows and screen edge */
static const int swallowfloating    = 0; /* 1 means swallow floating windows by default */
static const int smartgaps          = 1; /* 1 means no outer gap when there is only one window */
static const int showbar            = 0; /* 0 means no bar */
static const int topbar             = 1;  /* 0 means bottom bar */

/* Colors */
static const char normfgcolor[]     = "#bdc3af";
static const char normbgcolor[]     = "#000000";
static const char normbordercolor[] = "#1D1D1D";

static const char selfgcolor[]      = "#a38a5b";
static const char selbgcolor[]      = "#000000";
static const char selbordercolor[]  = "#340A24";

static const char *colors[][3] = {
    /*               fg           bg           border   */
  [SchemeNorm] = { normfgcolor, normbgcolor, normbordercolor },
  [SchemeSel]  = { selfgcolor,  selbgcolor,  selbordercolor },
};

/*  Fonts  */
static const char *fonts[] = { "IntoneMono Nerd Font Mono:size=8:antialias=true:autohint=true" };

/* Tagging */
static const char *tags[] = { " ", " ", " " };

/*  Scratchpad - Floating terminal */
typedef struct {
  const char *name;
  const void *cmd;
} Sp;
const char *spcmd1[] = {TERMINAL, "-n", "spcalc", "-f", "JetBrainsMono Nerd Font:size=12", "-g", "35x12", "-e", "qalc", NULL};
const char *spcmd2[] = {TERMINAL, "-n", "spclok", "-g", "37x09", "-e", "tty-clock", "-C", "7", NULL};
const char *spcmd3[] = {TERMINAL, "-n", "spaudi", "-g", "100x26", "-e", "pulsemixer", NULL};
static Sp scratchpads[] = {
  /* name      cmd  */
  { "spcalc", spcmd1 },
  { "spclok", spcmd2 },
  { "spaudi", spcmd3 },
};

static const Rule rules[] = {
  /* xprop(1):
   *	WM_CLASS(STRING) = instance, class
   *	WM_NAME(STRING) = title
   */
  /* Class-Instance-Title-Tags-Mask-Isfloating-Isterminal-Noswallow-Monitor */
  { "floorp",     NULL,         NULL,     1 << 1,    0,    0,    0,    -1 },
  { TERMCLASS,    NULL,         NULL,          0,    0,    1,    0,    -1 },
  { TERMCLASS,    "floatterm",  NULL,          0,    1,    1,    0,    -1 },
  { TERMCLASS,    "bg",         NULL,     1 << 7,    0,    1,    0,    -1 },
  { TERMCLASS,    "spcalc",     NULL,   SPTAG(0),    1,    1,    0,    -1 },
  { TERMCLASS,    "spclok",     NULL,   SPTAG(1),    1,    1,    0,    -1 },
  { TERMCLASS,    "spaudi",     NULL,   SPTAG(2),    1,    1,    0,    -1 },
};

/* Layout(s) */
static const float mfact        = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster        = 1; /* number of clients in master area */
static const int resizehints    = 0; /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

#define FORCE_VSPLIT 1 /* force two clients to always split vertically */
#include "options/vanitygaps.c"

static const Layout layouts[] = {
  /* symbol arrange function */
  { "[]=", tile    },  /* Default: Master on left, slaves on right */
  { "TTT", bstack  },  /* Master on top, slaves on bottom */
  { "[M]", monocle },  /* All windows on top of eachother */
  { "H[]", deck    },  /* Master on left, slaves in monocle-like mode on right */
  { "><>", NULL    },  /* no layout function means floating behavior */
  { NULL,  NULL    },
};

/* Key definitions */
#define MODKEY Mod4Mask               /* Super Key*/
#define MSHIFT Mod4Mask | ShiftMask /* Super + Shift */
#define TAGKEYS(KEY, TAG)                                                  \
  {MODKEY, KEY, view, {.ui = 1 << TAG}},                                   \
  {MODKEY | ControlMask, KEY, toggleview, {.ui = 1 << TAG}},               \
  {MODKEY | ShiftMask, KEY, tag, {.ui = 1 << TAG}},                        \
  {MODKEY | ControlMask | ShiftMask, KEY, toggletag, {.ui = 1 << TAG}},
#define STACKKEYS(MOD, ACTION)                                             \
  {MOD, XK_l, ACTION##stack, {.i = INC(+1)}},                              \
  {MOD, XK_h, ACTION##stack, {.i = INC(-1)}},                              \
  {MOD, XK_v, ACTION##stack, {.i = 0}},                                    \
  /* { MOD, XK_grave, ACTION##stack, {.i = PREVSEL } }, \ */
  /* { MOD, XK_a,     ACTION##stack, {.i = 1 } }, \ */
  /* { MOD, XK_z,     ACTION##stack, {.i = 2 } }, \ */
  /* { MOD, XK_x,     ACTION##stack, {.i = -1 } }, */

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd){ .v = (const char *[]) { "/bin/sh", "-c", cmd, NULL } }

/* User Commands */
static const char dmenumon[2] = "0";
static const char *dmenucmd[] = { "dmenu_run", NULL };
static const char *termcmd[]  = { TERMINAL, NULL };

static const char *lockcmd[]  = { "slock", NULL };
static const char *xsctcmd[]  = { "xsct", "-t", NULL };
static const char *browser[]  = { BROWSER, NULL };
static const char *keyboard[] = { "dm-kbselect", NULL };
static const char *sysact[]   = { "dm-sysact", NULL };
static const char *capture[]  = { "dm-capture", NULL };
static const char *passmenu[] = { "dm-pass", NULL };
static const char *xscreen[]  = { "dm-xscreen", NULL };
static const char *emacsc[]   = { "emacsclient", "-c", "-a", "", NULL };
static const char *clipbrd[]  = { "dm-clipboard", NULL };

/* Preferences */
#include <X11/XF86keysym.h>

static const Key keys[] = {
	/* modifier          key       function        argument */
	STACKKEYS(MODKEY,               focus )
	STACKKEYS(MSHIFT,               push  )

  /* TAGS */
	TAGKEYS( XK_g, 0 )
	TAGKEYS( XK_c, 1 )
	TAGKEYS( XK_r, 2 )

  /* LAYOUTS KEYMAPS */
	{ MODKEY,    XK_t,              setlayout,          { .v = &layouts[0] } },	/* tile si */
	{ MSHIFT,    XK_t,              setlayout,          { .v = &layouts[1] } },	/* bstack */
	{ MODKEY,    XK_m,              setlayout,          { .v = &layouts[2] } },	/* monocle si */
	{ MSHIFT,    XK_m,              setlayout,          { .v = &layouts[3] } },	/* deck si*/
	{ MSHIFT,    XK_v,              setlayout,          {0} },

  // FLOATING WINDOWS
	{ MODKEY,    XK_p,              togglescratch,      { .ui = 2 } }, // Pavucontrol
	{ MODKEY,    XK_apostrophe,     togglescratch,      { .ui = 0 } }, // Calculator
	{ MODKEY,    XK_semicolon,      togglescratch,      { .ui = 1 } }, // Clock
	{ MSHIFT,    XK_f,              togglefloating,     {0} },

  /* GENERAL SYSTEM KEYMAPS */
	{ MODKEY,    XK_Tab,            view,               {0} },
	{ MSHIFT,    XK_w,              killclient,         {0} },
	{ MODKEY,    XK_f,              togglefullscr,      {0} },
	{ MODKEY,    XK_space,          zoom,               {0} },
	{ MODKEY,    XK_j,              setmfact,	        { .f = -0.03 } },
	{ MODKEY,    XK_k,              setmfact,           { .f = +0.03 } },

  /* WINDOW GAPS */
	{ MSHIFT,    XK_a,              defaultgaps,        {0} },
	{ MODKEY,    XK_s,              togglesticky,       {0} },
	{ MODKEY,    XK_z,              incrgaps,           { .i = +2 } },
	{ MODKEY,    XK_x,              incrgaps,           { .i = -2 } },
	{ MODKEY,    XK_b,              togglebar,          {0} },

  /* EXTERNAL MONITOR */
	{ MSHIFT,    XK_plus,           focusmon,           { .i = -1 } },
	{ MSHIFT,    XK_bracketright,   focusmon,           { .i = +1 } },
	{ MSHIFT,    XK_Left,           tagmon,             { .i = -1 } },
	{ MSHIFT,    XK_Right,          tagmon,             { .i = +1 } },

  /* PERSONAL COMMANDS */
	{ MODKEY,    XK_Return,         spawn,      { .v = termcmd  } },
	{ MSHIFT,    XK_Return,         spawn,      { .v = emacsc   } }, // Emacs client
	{ MODKEY,    XK_d,              spawn,      { .v = dmenucmd } }, // dmenu
	{ MSHIFT,    XK_d,              spawn,      { .v = passmenu } }, // passmenu
	{ MODKEY,    XK_bracketleft,    spawn,      { .v = browser  } }, // Firefox
	{ MSHIFT,    XK_BackSpace,      spawn,      { .v = sysact   } }, // Systemt control
	{ MSHIFT,    XK_k,              spawn,      { .v = keyboard } }, // Change keymap
	{ 0,         XK_Print,          spawn,      { .v = capture  } }, // Screenshot
	{ MSHIFT,    XK_s,              spawn,      { .v = xsctcmd  } }, // Set color temperature of screen
	{ 0,         XK_F7,             spawn,      { .v = lockcmd  } }, // Lock screen
	{ 0,         XK_F8,             spawn,      { .v = xscreen  } }, // Share screen
	{ MODKEY,    XK_v,              spawn,      { .v = clipbrd  } }, // Clipboard with dmenu

  /* Audio Output */
	{ MSHIFT,    XK_ampersand,      spawn,      SHCMD("pacmd set-sink-port alsa_output.pci-0000_00_1b.0.analog-stereo analog-output-speaker") },
	{ MSHIFT,    XK_bracketleft,    spawn,      SHCMD("pacmd set-sink-port alsa_output.pci-0000_00_1b.0.analog-stereo analog-output-headphones") },

  /* Fn Keymaps */
	{ 0, XF86XK_AudioMute,          spawn,      SHCMD("amixer -q sset Master toggle; pkill -RTMIN+10 dwmblocks") },
	{ 0, XF86XK_AudioRaiseVolume,   spawn,      SHCMD("amixer -q sset Master 5%+; pkill -RTMIN+10 dwmblocks")},
	{ 0, XF86XK_AudioLowerVolume,   spawn,      SHCMD("amixer -q sset Master 5%-; pkill -RTMIN+10 dwmblocks")},

	{ 0, XF86XK_MonBrightnessUp,    spawn,      SHCMD("light -A 5; pkill -RTMIN+5 dwmblocks") },
	{ 0, XF86XK_MonBrightnessDown,  spawn,      SHCMD("light -U 5; pkill -RTMIN+5 dwmblocks") },

	{ 0, XF86XK_AudioPrev,          spawn,      SHCMD("playerctl previous; pkill -RTMIN+12 dwmblocks") },
	{ 0, XF86XK_AudioNext,          spawn,      SHCMD("playerctl next; pkill -RTMIN+12 dwmblocks") },
	{ 0, XF86XK_AudioPause,         spawn,      SHCMD("playerctl play-pause; pkill -RTMIN+12 dwmblocks") },
	{ 0, XF86XK_AudioPlay,          spawn,      SHCMD("playerctl play-pause; pkill -RTMIN+12 dwmblocks") },
	{ 0, XF86XK_AudioStop,          spawn,      SHCMD("playerctl stop; pkill -RTMIN+12 dwmblocks") },
};

static const Button buttons[] = {
#ifndef __OpenBSD__
    {ClkWinTitle, 0, Button2, zoom, {0}},
    {ClkStatusText, 0, Button1, sigdwmblocks, {.i = 1}},
    {ClkStatusText, 0, Button2, sigdwmblocks, {.i = 2}},
    {ClkStatusText, 0, Button3, sigdwmblocks, {.i = 3}},
    {ClkStatusText, 0, Button4, sigdwmblocks, {.i = 4}},
    {ClkStatusText, 0, Button5, sigdwmblocks, {.i = 5}},
    {ClkStatusText, ShiftMask, Button1, sigdwmblocks, {.i = 6}},
#endif
    {ClkStatusText, ShiftMask, Button3, spawn, {0}},
    {ClkClientWin, MODKEY, Button1, movemouse, {0}},
    {ClkClientWin, MODKEY, Button2, defaultgaps, {0}},
    {ClkClientWin, MODKEY, Button3, resizemouse, {0}},
    {ClkClientWin, MODKEY, Button4, incrgaps, {.i = +1}},
    {ClkClientWin, MODKEY, Button5, incrgaps, {.i = -1}},
    {ClkTagBar, 0, Button1, view, {0}},
    {ClkTagBar, 0, Button3, toggleview, {0}},
    {ClkTagBar, MODKEY, Button1, tag, {0}},
    {ClkTagBar, MODKEY, Button3, toggletag, {0}},
    {ClkRootWin, 0, Button2, togglebar, {0}},
};
