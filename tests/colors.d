import std.string;
import std.stdio;
import std.typetuple;
import libfab;

enum BASECOLORS = TypeTuple!("BLACK", "RED", "GREEN", "YELLOW", "BLUE", "MAGENTA", "CYAN", "WHITE");
enum TSTRING = "Hello There";

void main() {
	with(libfab.Color) {
		foreach(fmt; TypeTuple!(BOLD, ITALIC, UNDER, UNDER2, STRIKE, BLINK, FLIP)) {
			"%s-ing it up: '%s'".writefln(fmt, TSTRING.apply_color(fmt));
		}

		foreach(prefix; TypeTuple!("", "H", "BG")) {
			"------------------".writeln();
			foreach(color; BASECOLORS) {
				enum name = "%s%s".format(prefix, color);
				"%s-ing it up: '%s'".writefln(name, TSTRING.apply_color(mixin(name)));
			}
		}

		"------------------".writeln();
		rgb_t c = {120, 0, 100};
		"256FG-ing it up: '%s'".writefln(TSTRING.foreground_256(c));
		"256BG-ing it up: '%s'".writefln(TSTRING.background_256(c));
		"256HI-ing it up: '%s'".writefln(TSTRING.highlight_256(c));

		"------------------".writeln();
		foreach(fg; BASECOLORS) {
			foreach(bg; BASECOLORS) {
				"XX".apply_color(mixin(fg)).apply_color(mixin("BG"~bg)).write(" ");
			}
			writeln();
		}

		/+
		xcolor_image_t *image = image_to_xterm("/home/rossdylan/Downloads/10469154_10204348274165961_3225173628639169213_o.jpg");
		reduce_image(image);
		+/
	}
}
