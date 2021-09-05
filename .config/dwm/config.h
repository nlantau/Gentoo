/* See LICENSE file for copyright and license details. */

#include <X11/XF86keysym.h>


/* appearance */
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int gappx     = 10;        /* gaps between windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
//static const char *fonts[]          = { "monospace:size=8" };
//static const char dmenufont[]       = "monospace:size=8";
static const char *fonts[]          = { "Cantarell:size=9" };
static const char dmenufont[]       = "Cantarell:size=9";
static const char col_gray1[]       = "#222222";
static const char col_gray2[]       = "#444444";
static const char col_gray3[]       = "#bbbbbb";
static const char col_gray4[]       = "#eeeeee";
static const char col_cyan[]        = "#09222b";
static const char col_pink[]        = "#00d138";
static const char red[]             = "#ff0000";
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
	[SchemeSel]  = { col_gray4, col_cyan,  col_pink  },
};


typedef struct {
	const char *name;
	const void *cmd;
} Sp;

/* Scratchpads  */
const char *spcmd1[] = {"st", "-n", "spterm", "-g", "80x34", NULL };
const char *spcmd2[] = {"st", "-n", "spfm", "-g", "120x34", "-e", "ranger", NULL };
const char *spcmd3[] = {"st", "-n", "sppy", "-g", "80x34", "-e", "ipython", "--no-banner", NULL };
static Sp scratchpads[] = {
	/* name          cmd  */
	{"spterm",      spcmd1},
	{"spranger",    spcmd2},
	{"sppy",   spcmd3},
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };
static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   monitor */
	{ "Gimp",	  NULL,			NULL,		0,		    	1,			 -1 },
	//{ "Firefox",      NULL,			NULL,		1 << 8,			0,			 -1 },
	{ NULL,		  "spterm",		NULL,		SPTAG(0),		1,			 -1 },
	{ NULL,		  "spfm",		NULL,		SPTAG(1),		1,			 -1 },
	{ NULL,		  "sppy",       	NULL,		SPTAG(2),		1,			 -1 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
	{ "|M|",      centeredmaster },
	{ ">M>",      centeredfloatingmaster },
};

/* key definitions */
/* Mod1Mask = Alt; Mod4Mask = Super */
#define MODKEY Mod4Mask
#define MODALT Mod1Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, NULL };
static const char *termcmd[]  = { "alacritty", "-e", "tmux", NULL };

/* Applications */
static const char *intellij[]  = { "idea-ultimate", NULL };
static const char *flame[]  = { "flameshot","gui", NULL };

/* Monitors */
static const char *enabledualmonitors[]  = { "/home/nlantau/.config/scripts/monitors","dual", NULL };
static const char *enabletriplemonitors[]  = { "/home/nlantau/.config/scripts/monitors","triple", NULL };
static const char *enablelaptopHDMImonitors[]  = { "/home/nlantau/.config/scripts/monitors","laptop-hdmi", NULL };
static const char *disabledualmonitors[]  = { "/home/nlantau/.config/scripts/monitors","laptop", NULL };
static const char *locker[] = {"slock", NULL};
static const char *bgchanger[] = {"/home/nlantau/.config/scripts/bg_switcher", NULL};

/* Sound */
static const char *mutecmd[] = { "/usr/bin/pactl","set-sink-mute","0","toggle", NULL };
static const char *volupcmd[] = { "/usr/bin/pactl","set-sink-volume","0","+5%", NULL };
static const char *voldowncmd[] = { "/usr/bin/pactl","set-sink-volume","0","-5%", NULL };
static const char *miccmd[] = { "/usr/bin/pactl","set-source-mute","@DEFAULT_SOURCE@","toggle", NULL };

/* Backlight */
static const char *brupcmd[] = { "sudo", "xbacklight", "-inc", "1", NULL };
static const char *brdowncmd[] = { "sudo", "xbacklight", "-dec", "1", NULL };
static const char *brlowcmd[] = { "sudo", "xbacklight", "-set", "1", NULL };

/* Power */
static const char *susp[] = {"/home/nlantau/.config/scripts/susp_lock",NULL};
//static const char *susp[] = {"sudo","s2ram",NULL};
//static const char *susp[] = {"power", NULL};


static Key keys[] = {

	/* Kill, Quit & Power                                               */
	{ MODKEY|ShiftMask,             XK_q,      quit,           {0} },
	{ MODKEY,                       XK_q,      killclient,     {0} },
	{ MODKEY,                       XK_z,      spawn,          {.v = locker } },
        { MODALT|ShiftMask,             XK_x,      spawn,          {.v = susp } },         
        { MODALT|ShiftMask,             XK_b,      spawn,          {.v = bgchanger } },         

        /* Spawn cmd                                                        */
	{ MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },
	{ MODKEY,                       XK_Return, spawn,          {.v = termcmd } },

        /* Layout                                                           */
	{ MODKEY|ShiftMask,             XK_Return, zoom,           {0} },             /* Will be master tile */
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_u,      setlayout,      {.v = &layouts[3]} },
	{ MODKEY,                       XK_o,      setlayout,      {.v = &layouts[4]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY,                       XK_Tab,    view,           {0} },

        /* Focus                                                            */
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
        { MODKEY|ControlMask,           XK_space,  focusmaster,    {0} },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },

        /* Gaps                                                             */
	{ MODKEY,                       XK_minus,  setgaps,        {.i = -1 } },
	{ MODKEY,                       XK_plus,   setgaps,        {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_plus,   setgaps,        {.i = 0  } },

        /* Scratchpads                                                      */
	{ MODALT,                       XK_a,      togglescratch,  {.i = 1  } },
	{ MODALT,                       XK_u,      togglescratch,  {.i = 0  } },
	{ MODALT,                       XK_y,      togglescratch,  {.i = 2  } },

        /* Spawn scripts                                                    */
        { MODALT|ShiftMask,             XK_s,      spawn,          {.v = disabledualmonitors } },         
        { MODALT|ShiftMask,             XK_d,      spawn,          {.v = enabledualmonitors } },         
        { MODALT|ShiftMask,             XK_t,      spawn,          {.v = enabletriplemonitors } },         
        { MODALT|ShiftMask,             XK_h,      spawn,          {.v = enablelaptopHDMImonitors } },         
        { MODALT|ShiftMask,             XK_p,      spawn,          {.v = flame } },         
        { MODALT,                       XK_l,      spawn,          {.v = brlowcmd } },
        { MODALT|ShiftMask,             XK_j,      spawn,          {.v = intellij } },

        /* XF86                                                             */
        { 0,                            XF86XK_AudioMute,          spawn, {.v = mutecmd } },
        { 0,                            XF86XK_AudioMicMute,       spawn, {.v = miccmd } },
        { 0,                            XF86XK_AudioLowerVolume,   spawn, {.v = voldowncmd } },
        { 0,                            XF86XK_AudioRaiseVolume,   spawn, {.v = volupcmd } },
        { 0,                            XF86XK_MonBrightnessUp,    spawn, {.v = brupcmd} },
        { 0,                            XF86XK_MonBrightnessDown,  spawn, {.v = brdowncmd} },

        /* Tags                                                             */
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },

	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button1,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

