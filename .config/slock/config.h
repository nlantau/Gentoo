/* user and group to drop privileges to */
static const char *user  = "nlantau";
static const char *group = "nlantau";

static const char *colorname[NUMCOLS] = {
	[INIT] =   "black",     /* after initialization */
	[INPUT] =  "#005577",   /* during input */
	[FAILED] = "#CC3333",   /* wrong password */
};

static const int failonclear = 1;

#define BLUR
static const int blurRadius=5;
static const int pixelSize=2;

static const char* message = "Suckless: Software that sucks less.";
static const char* text_color ="#FF0000";
//static const char* font_name = "-misc-fixed-medium-r-semicondensed--0-0-75-75-c-0-iso8859-1";
static const char* font_name = "-misc-fixed-medium-r-semicondensed--13-100-100-100-c-60-iso8859-1";
