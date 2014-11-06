module libfab.fab;

extern(C):

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

struct rgb_t {
	int r;
	int g;
	int b;
}

char *apply_color(Color c, const(char)* line);

char *foreground_256(rgb_t color, const(char)* line);
char *background_256(rgb_t color, const(char)* line);
char *highlight_256(rgb_t color, const(char)* line);
