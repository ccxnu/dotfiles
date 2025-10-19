/* user and group to drop privileges to */
static const char *user  = "nobody";
static const char *group = "nogroup";

static const char *colorname[NUMCOLS] = {
	[INIT] =   "#000000",     /* after initialization */
	[INPUT] =  "#090012",   /* during input */
	[FAILED] = "#290A08",   /* wrong password */
};

/* lock screen opacity */
static const float alpha = 0.87;

/* treat a cleared input like a wrong password (color) */
static const int failonclear = 1;

/* default message */
static const char * message =
    "           |\\      _,,,---,,_              \n"
    "     ZZZzz /,`.-'`'    -.  ;-;;,_           \n"
    "          |,4-  ) )-,_. ,\\ (  `'-'         \n"
    "         '---''(_/--'  `-'\\_)  ccxnu       \n"
    "\n"
    "           It's okay to live hard.         \n"
    "\n"
    "                Clear is better than clever.\n"
    "I optimize for reading code, not writing it.";

/* text color */
static const char * text_color = "#F2EFEB";

/* text size (must be a valid size) */
static char *font = "IntoneMono Nerd Font Mono:pixelsize=16:antialias=true:autohint=true";
