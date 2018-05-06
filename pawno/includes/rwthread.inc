/*
	
	NON-blocking Threaded fread / fwrite
	2011 Jernej L.
	
*/

native ThreadW(file[], text[]);
native ThreadR(file[], callback[], beginoffset = 0, extraid = -1);
