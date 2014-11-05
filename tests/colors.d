import std.stdio;
import libfab;


void main() {
	with(libfab.Color) {
		"BOLDING-ing it up: '%s'".writefln("Hello There".apply_format(BOLD));
		"ITALIC-ing it up: '%s'".writefln("Hello There".apply_format(ITALIC));
		"UNDER-ing it up: '%s'".writefln("Hello There".apply_format(UNDER));
		"UNDER2-ing it up: '%s'".writefln("Hello There".apply_format(UNDER2));
		"STRIKE-ing it up: '%s'".writefln("Hello There".apply_format(STRIKE));
		"BLINK-ing it up: '%s'".writefln("Hello There".apply_format(BLINK));
		"FLIP-ing it up: '%s'".writefln("Hello There".apply_format(FLIP));

		"------------------".writeln();
		"BLACK-ing it up: '%s'".writefln("Hello There".apply_format(BLACK));
		"RED-ing it up: '%s'".writefln("Hello There".apply_format(RED));
		"GREEN-ing it up: '%s'".writefln("Hello There".apply_format(GREEN));
		"YELLOW-ing it up: '%s'".writefln("Hello There".apply_format(YELLOW));
		"BLUE-ing it up: '%s'".writefln("Hello There".apply_format(BLUE));
		"MAGENTA-ing it up: '%s'".writefln("Hello There".apply_format(MAGENTA));
		"CYAN-ing it up: '%s'".writefln("Hello There".apply_format(CYAN));
		"WHITE-ing it up: '%s'".writefln("Hello There".apply_format(WHITE));

		"------------------".writeln();
		"HIGHLIGHT-BLACK-ing it up: '%s'".writefln("Hello There".apply_format(HBLACK));
		"HIGHLIGHT-RED-ing it up: '%s'".writefln("Hello There".apply_format(HRED));
		"HIGHLIGHT-GREEN-ing it up: '%s'".writefln("Hello There".apply_format(HGREEN));
		"HIGHLIGHT-YELLOW-ing it up: '%s'".writefln("Hello There".apply_format(HYELLOW));
		"HIGHLIGHT-BLUE-ing it up: '%s'".writefln("Hello There".apply_format(HBLUE));
		"HIGHLIGHT-MAGENTA-ing it up: '%s'".writefln("Hello There".apply_format(HMAGENTA));
		"HIGHLIGHT-CYAN-ing it up: '%s'".writefln("Hello There".apply_format(HCYAN));
		"HIGHLIGHT-WHITE-ing it up: '%s'".writefln("Hello There".apply_format(HWHITE));

		"------------------".writeln();
		"BACKGROUND-BLACK-ing it up: '%s'".writefln("Hello There".apply_format(BGBLACK));
		"BACKGROUND-RED-ing it up: '%s'".writefln("Hello There".apply_format(BGRED));
		"BACKGROUND-GREEN-ing it up: '%s'".writefln("Hello There".apply_format(BGGREEN));
		"BACKGROUND-YELLOW-ing it up: '%s'".writefln("Hello There".apply_format(BGYELLOW));
		"BACKGROUND-BLUE-ing it up: '%s'".writefln("Hello There".apply_format(BGBLUE));
		"BACKGROUND-MAGENTA-ing it up: '%s'".writefln("Hello There".apply_format(BGMAGENTA));
		"BACKGROUND-CYAN-ing it up: '%s'".writefln("Hello There".apply_format(BGCYAN));
		"BACKGROUND-WHITE-ing it up: '%s'".writefln("Hello There".apply_format(BGWHITE));

		"------------------".writeln();
		rgb_t c = {120, 0, 100};
		"256FG-ing it up: '%s'".writefln("Hello There".foreground_256(c));
		"256BG-ing it up: '%s'".writefln("Hello There".background_256(c));
		"256HI-ing it up: '%s'".writefln("Hello There".highlight_256(c));

		/+
		xcolor_image_t *image = image_to_xterm("/home/rossdylan/Downloads/10469154_10204348274165961_3225173628639169213_o.jpg");
		reduce_image(image);
		+/
	}
}
