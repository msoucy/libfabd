/******************************************************************************
 * D wrappers for the C functions
 */
module fabd.dfab;

import cfab = fabd.fab;
alias Color = cfab.Color;

import std.string;
import std.typecons;
import std.conv;

private string takeown(char* cptr)
{
	import core.stdc.string : strlen;
	import core.stdc.stdlib : free;
	auto dstr = cptr[0 .. strlen(cptr)].idup;
	free(cptr);
	return dstr;
}

private template MakeBinding(string name) {
	string bindfunc(String)(String line, cfab.rgb_t c) {
		return BindFunc(c, line);
	}
	string bindfunc(String)(cfab.rgb_t c, String line) {
		return mixin("cfab."~name)(c, line.toStringz).takeown;
	}
	mixin("alias " ~ name ~ " = bindfunc;");
}

string apply_color(String)(String line, Color c)
{
	return apply_color(c, line);
}
string apply_color(String)(Color c, String line)
{
	return cfab.apply_color(c, line.toStringz).takeown;
}

mixin MakeBinding!"foreground_256";
mixin MakeBinding!"background_256";
mixin MakeBinding!"highlight_256";

cfab.rgb_t xterm_to_rgb(int xcolor)
{
	auto res = cfab.xterm_to_rgb_i(xcolor);
	return cfab.rgb_t(
		(res>>16) & 0xFF,
		(res>>8) & 0xFF,
		res & 0xFF
	);
}

auto rgb(int r, int g, int b) {
	return cfab.rgb_t(r, g, b);
}

auto Image(string path)
{
	return new class Object {
	public:
		this()
		{
			data = cfab.image_to_xterm(path.toStringz);
		}
		void toString(scope void delegate(const(char)[]) sink) const
		{
			auto img_text = cfab.image_to_string(data);
			scope(exit) core.stdc.stdlib.free(img_text);
			sink(img_text.to!string);

		}
		~this() {
			cfab.xcolor_image_free(data);
		}
	public:
		cfab.xcolor_image_t* data;
	};
}

unittest {
	// Test styles
	import std.algorithm;
	import std.range : chain;
	import std.conv;
	enum T = "Hello There";
	auto test_generic(Color c, string prefix, string suffix)
	{
		return equal(T.apply_color(c).to!string, chain(prefix, T, suffix));
	}
	with(Color) {
		assert(test_generic(BOLD, "\x1b[1m", "\x1b[22m"));
		assert(test_generic(ITALIC, "\x1b[3m", "\x1b[23m"));
		assert(test_generic(UNDER, "\x1b[4m", "\x1b[24m"));
		assert(test_generic(UNDER2, "\x1b[21m", "\x1b[24m"));
		assert(test_generic(STRIKE, "\x1b[9m", "\x1b[29m"));
		assert(test_generic(BLINK, "\x1b[5m", "\x1b[25m"));
		assert(test_generic(FLIP, "\x1b[7m", "\x1b[27m"));
	}
}

unittest {
	// Test colors
	import std.algorithm;
	import std.range;
	import std.conv;
	enum T = "Hello There";
	auto test_color(Color c, string prefix)
	{
		return equal(T.apply_color(c).to!string, chain(prefix, T, "\x1b[39m"));
	}
	with(Color) {
		assert(test_color(BLACK, "\x1b[30m"));
		assert(test_color(RED, "\x1b[31m"));
		assert(test_color(GREEN, "\x1b[32m"));
		assert(test_color(YELLOW, "\x1b[33m"));
		assert(test_color(BLUE, "\x1b[34m"));
		assert(test_color(MAGENTA, "\x1b[35m"));
		assert(test_color(CYAN, "\x1b[36m"));
		assert(test_color(WHITE, "\x1b[37m"));
	}
}

