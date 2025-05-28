# pformat

pformat is a utility for taking a binary file as input and formatting to
be usable as either:
- python buffer
- c buffer
- raw bytes

This tool was created because I found myself often printing shellcode into
a file and then later wanting to use it in a script.

## installation

This is a very simple, single-file program. It can be built with:
```
$ gcc pformat.c -o pformat
```

It can be installed with:
```
$ ln -s pformat /usr/bin/
```

And it can be uninstalled with:
```
$ rm /usr/bin/pformat
```

## usage
```

Usage: pformat <option> <filename>

options:
	p : format output for python
	c : format output for C
	r : output raw bytes

$ pformat c output

char buffer[] = "\x41\x41\x41\x41\x41\x41\x41\x41\x41\x41\x41\x41"
		"\x41\x41\x41\x41\x41\x41\x41\x41\x41\x41\x41\x41"
		"\x41\x41\x41\x41\x41\x41\x41\x41\x41\x41\x41\x41"
		"\x0a";
$ pformat p output

buffer = b"\x41\x41\x41\x41\x41\x41\x41\x41\x41\x41\x41\x41"
buffer += b"\x41\x41\x41\x41\x41\x41\x41\x41\x41\x41\x41\x41"
buffer += b"\x41\x41\x41\x41\x41\x41\x41\x41\x41\x41\x41\x41"
buffer += b"\x0a"

$ pformat r output

41 41 41 41 41 41 41 41 41 41 41 41 
41 41 41 41 41 41 41 41 41 41 41 41 
41 41 41 41 41 41 41 41 41 41 41 41 
0a 

```



