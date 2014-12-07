module libfab.dfab;

import cfab = libfab.fab;
alias Color = cfab.Color;

import std.string;
import std.typecons;

class CString {
	this(char* ptr) {
		raw = ptr;
	}
	void toString(scope void delegate(const(char)[]) sink) const
	{
		sink(raw.fromStringz);
	}
	immutable(char)* toStringz() pure nothrow
	{
		return cast(immutable(char)*)(raw);
	}
	~this() {
		core.stdc.stdlib.free(raw);
	}
	char* raw;
	alias raw this;
}

private template MakeBinding(string name) {
	CString BindFunc(String)(String line, cfab.rgb_t c) {
		return BindFunc(c, line);
	}
	CString BindFunc(String)(cfab.rgb_t c, String line) {
		return new CString(mixin("cfab."~name)(c, line.toStringz));
	}
	mixin("alias " ~ name ~ " = BindFunc;");
}

CString apply_color(String)(String line, Color c)
{
	return apply_color(c, line);
}
CString apply_color(String)(Color c, String line)
{
	return new CString(cfab.apply_color(c, line.toStringz));
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
			sink(img_text.fromStringz);
			core.stdc.stdlib.free(img_text);

		}
		~this() {
			cfab.xcolor_image_free(data);
		}
	public:
		cfab.xcolor_image_t* data;
	};
}
