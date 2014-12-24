/++
	D wrappers for the C functions

	Authors: Matthew Soucy, msoucy@csh.rit.edu
	License: Subject to the terms of the MIT license, as written in the included LICENSE file.
+/
module fabd.dfab;

import cfab = fabd.fab;
import fabd.fab : Color, rgb_t;

import std.string : toStringz;
import std.conv : to;
import std.traits : isSomeString;

private string takeown(char* cptr)
{
	import core.stdc.string : strlen;
	import core.stdc.stdlib : free;
	// When fromStringz is in default repos (IE ldc on Fedora)
	// it should be used instead of manually reimplementing it
	auto dstr = cptr[0 .. strlen(cptr)].idup;
	free(cptr);
	return dstr;
}

/++
	Applies the color $(D c) to $(D text).

	Returns the string created as a result
+/
string apply_color(String)(String text, Color c)
	if(isSomeString!String)
{
	return cfab.apply_color(c, text.toStringz).takeown;
}

/++
	Applies the $(D c) to the foreground of $(D text)
+/
string foreground_256(String)(String text, rgb_t c)
	if(isSomeString!String)
{
	return cfab.foreground_256(c, text.toStringz).takeown;
}

/++
	Applies the $(D c) to the background of $(D text)
+/
string background_256(String)(String text, rgb_t c)
	if(isSomeString!String)
{
	return cfab.background_256(c, text.toStringz).takeown;
}

/++
	Highlights $(D text) with the color $(D c)
+/
string highlight_256(String)(String text, rgb_t c)
	if(isSomeString!String)
{
	return cfab.highlight_256(c, text.toStringz).takeown;
}

/++
	Converts an xterm color number into an RGB value
+/
rgb_t xterm_to_rgb(int xcolor)
{
	auto res = cfab.xterm_to_rgb_i(xcolor);
	return cfab.rgb_t(
		(res>>16) & 0xFF,
		(res>>8) & 0xFF,
		res & 0xFF
	);
}

/++
	Create an $(D rgb_t)
	Params:
		r = The amount of red
		g = The amount of green
		b = The amount of blue
+/
auto rgb(ubyte r, ubyte g, ubyte b) {
	return rgb_t(r, g, b);
}

///Stores converted image data
struct Image
{
public:
	/++
		Load an image
		Params:
			path = The name of the file to load the image from
	+/
	this(string path)
	{
		auto xti = cfab.image_to_xterm(path.toStringz);
		scope(exit) cfab.xcolor_image_free(xti);
		image = cfab.image_to_string(xti).takeown;
	}
	/// Prints the image
	void toString(scope void delegate(const(char)[]) sink) const
	{
		sink(image);
	}
private:
	@disable this();

	string image;
}

unittest {
	// Test styles
	import std.algorithm : equal;
	import std.range : chain;
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
	import std.algorithm : equal;
	import std.range : chain;
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

