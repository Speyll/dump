/* See LICENSE file for copyright and license details. */
/* Default settings; can be overriden by command line. */
#include <stdbool.h>
static int topbar = 1;                      /* -b  option; if 0, dmenu appears at bottom     */
/* -fn option overrides fonts[0]; default X11 font or font set */
static const char *fonts[] = {
	"kakwafont:size=8",
	"Siji:size=8"
};
static const char *prompt      = NULL;      /* -p  option; prompt to the left of input field */
static const char *colors[SchemeLast][2] = {
	/*     fg         bg       */
	[SchemeNorm] = { "#657b83", "#002b36" },
	[SchemeSel] = { "#002b36", "#6c71c4" },
	[SchemeOut] = { "#657b83", "#6c71c4" },
};
/* -l option; if nonzero, dmenu uses vertical list with given number of lines */
static unsigned int lines      = 0;
static unsigned int lineheight = 24;         /* -h option; minimum height of a menu line     */

static const char xcol[4][8] = {
	//background
	"color0",
	//foreground
	"color7",
	//selection background 
	"color1",
	//selection foreground 
	"color0",
};


/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
static const char worddelimiters[] = "";
static bool key_mode = false; //use single key mode by default or not
