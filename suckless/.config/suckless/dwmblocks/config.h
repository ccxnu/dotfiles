//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
    /*Icon*/    /*Command*/    /*Update Interval*/ /*Update Signal*/
    {"",	"sb-keyboard",            0,	            30  },
    {"",	"sb-volume",	          0,	            10  },
    {"",	"sb-battery",	          3,	            3   },
    {"",	"sb-brightness",	      0,	            5   },
    {"",	"sb-internet",	          5,	            4   },
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char *delim = "  ";
static unsigned int delimLen = 5;
