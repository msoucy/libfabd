import std.string;
import std.stdio;
import core.memory;
import libfab;
import cfab = libfab.fab;

enum IMG = "/home/msoucy/Downloads/remyreddit.png";

void main() {
	Image(IMG).writeln();
}
