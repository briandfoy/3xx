# Tools to grab the Location header

I have to deal with lots of things that hide the actual URL from
me. I have to grab some quarantined URL to get the real URL. All
I want is the Location header:

	$ 3xx http://www.some-filter-thing.com/?deadbeef
	https://www.perl.com/

And, I have to do this in a variety of environments where different
tools are avialable so I've done the same thing in different tools.

## Exit codes

* 0   - Found a Location header
* 1   - The request was a success, but there was no Location header
* 2   - The request was some sort of error
* 255 - There was a program error

## Why not use curl?

Sure, show me how. But it's not as simple as sending a head request
and grabbing the Location header. Some servers won't respond to that
and I still have to strip out the header name. I end up with a pipeline
in an alias.
