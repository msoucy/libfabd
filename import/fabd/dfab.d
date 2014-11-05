module libfab.dfab;

import libfab.fab;
public import libfab.fab : Color, rgb_t;

import std.string;

string apply_format(string line, Color c)
{
	return apply_format(c, line);
}
string apply_format(Color c, string line)
{
	return libfab.fab.apply_format(c, line.toStringz).fromStringz.idup;
}

string foreground_256(string line, rgb_t color)
{ return foreground_256(color, line); }
string foreground_256(rgb_t color, string line)
{
	return libfab.fab.foreground_256(color, line.toStringz).fromStringz.idup;
}
string background_256(string line, rgb_t color)
{ return background_256(color, line); }
string background_256(rgb_t color, string line)
{
	return libfab.fab.background_256(color, line.toStringz).fromStringz.idup;
}
string highlight_256(string line, rgb_t color)
{ return highlight_256(color, line); }
string highlight_256(rgb_t color, string line)
{
	return libfab.fab.highlight_256(color, line.toStringz).fromStringz.idup;
}
