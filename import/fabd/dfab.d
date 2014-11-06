module libfab.dfab;

import libfab.fab;
public import libfab.fab : Color, rgb_t;

import std.string;

private template MakeBinding(string name) {
	string BindFunc(string line, rgb_t c) {
		return BindFunc(c, line);
	}
	string BindFunc(rgb_t c, string line) {
		return mixin("libfab.fab."~name)(c, line.toStringz).fromStringz.idup;
	}
	mixin("alias " ~ name ~ " = BindFunc;");
}

string apply_color(string line, Color c)
{
	return apply_color(c, line);
}
string apply_color(Color c, string line)
{
	return libfab.fab.apply_color(c, line.toStringz).fromStringz.idup;
}

mixin MakeBinding!"foreground_256";
mixin MakeBinding!"background_256";
mixin MakeBinding!"highlight_256";
