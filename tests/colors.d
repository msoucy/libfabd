import std.string;
import std.stdio;
import std.typetuple;
import libfab;


void main() {
	with(libfab.Color) {
		foreach(fmt; TypeTuple!(BOLD, ITALIC, UNDER, UNDER2, STRIKE, BLINK, FLIP)) {
			"%s-ing it up: '%s'".writefln(fmt, "Hello There".apply_format(fmt));
		}

		foreach(prefix; TypeTuple!("", "H", "BG")) {
			"------------------".writeln();
			foreach(color; TypeTuple!(BLACK, RED, GREEN, YELLOW, BLUE, MAGENTA, CYAN, WHITE)) {
				enum name = "%s%s".format(prefix, color);
				"%s-ing it up: '%s'".writefln(name, "Hello There".apply_format(mixin(name)));
			}
		}

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
