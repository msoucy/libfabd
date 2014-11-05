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

string apply_format(string line, Color c)
{
	return apply_format(c, line);
}
string apply_format(Color c, string line)
{
	return libfab.fab.apply_format(c, line.toStringz).fromStringz.idup;
}

mixin MakeBinding!"foreground_256";
mixin MakeBinding!"background_256";
mixin MakeBinding!"highlight_256";
