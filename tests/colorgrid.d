import std.stdio;
import libfab;

void main() {
	foreach(int i; 0..256) {
		"  ".background_256(i.xterm_to_rgb).write();
		if((i+1)%16 == 0) writeln();
	}
}
