/++
	D wrappers for the C functions

	Authors: Matthew Soucy, msoucy@csh.rit.edu
	License: Subject to the terms of the MIT license, as written in the included LICENSE file.
+/
module fabd.fab;

extern(C):

/// Wrap a color or special effect
enum Color {
    BOLD,
    ITALIC,
    UNDER,
    UNDER2,
    STRIKE,
    BLINK,
    FLIP,
    BLACK,
    RED,
    GREEN,
    YELLOW,
    BLUE,
    MAGENTA,
    CYAN,
    WHITE,
    HBLACK,
    HRED,
    HGREEN,
    HYELLOW,
    HBLUE,
    HMAGENTA,
    HCYAN,
    HWHITE,
    BGBLACK,
    BGRED,
    BGGREEN,
    BGYELLOW,
    BGBLUE,
    BGMAGENTA,
    BGCYAN,
    BGWHITE
}

/// Wrap an RGB color value
struct rgb_t {
	int r;
	int g;
	int b;
}


char* apply_color(Color c, const(char)* line);

char* foreground_256(rgb_t color, const(char)* line);
char* background_256(rgb_t color, const(char)* line);
char* highlight_256(rgb_t color, const(char)* line);

struct xcolor_image_t {}

int xterm_to_rgb_i(int);
xcolor_image_t* image_to_xterm(const(char)*);
char* image_to_string(const(xcolor_image_t)*);
void xcolor_image_free(xcolor_image_t*);

