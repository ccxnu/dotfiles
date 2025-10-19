/* See LICENSE file for copyright and license details. */
/* Default settings; can be overriden by command line. */

static int bottom = 0;
static int embedded = 0;
static int minpwlen = 32;
static int mon = -1;
static int lineheight = 0;
static int min_lineheight = 8;

static const char *asterisk = "*";
static const char *fonts[] = { "IntoneMono Nerd Font Mono:size=9" };
static const char *prompt = NULL;
static const char *colors[SchemeLast][4] = {
	[SchemePrompt] = { "#A38A5B", "#1D1D1D" },
	[SchemeNormal] = { "#A38A5B", "#000000" },
	[SchemeSelect] = { "#BDC3AF", "#1D1D1D" },
	[SchemeDesc]   = { "#BDC3AF", "#000000" }
};
