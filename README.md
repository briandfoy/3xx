# Tools to grab the Location header

I have to deal with lots of things that hide the actual URL from
me. I have to grab some quarantined URL to get the real URL. All
I want is the Location header:

	$ 3xx http://www.some-filter-thing.com/?deadbeef
	https://www.perl.com/

And, I have to do this in a variety of environments where different
tools are avialable so I've done the same thing in different tools.

## A little test program

There's a Mojolicious program that has four paths. Three of those
redirect in this chain:

	* http://127.0.0.1:3000/three
	* http://127.0.0.1:3000/two
	* http://127.0.0.1:3000/one
	* http://127.0.0.1:3000/none

Start the app:

	$ perl app.pl daemon
	[Tue Mar 19 21:15:09 2019] [info] Listening at "http://*:3000"
	Server available at http://127.0.0.1:3000

Now try it. Each prints the redirect chain. Standard output is the
URLs and anything else is on standard error.

	$ python3.7 python/3xx http://127.0.0.1:3000/three
	http://127.0.0.1:3000/two
	http://127.0.0.1:3000/one
	http://127.0.0.1:3000/none

	$ ruby ruby/3xx http://127.0.0.1:3000/two
	http://127.0.0.1:3000/one
	http://127.0.0.1:3000/none

	$ perl5.28.0 perl/3xx http://127.0.0.1:3000/one
	http://127.0.0.1:3000/none

Get the last one with `tail`:

	$ python3.7 python/3xx http://127.0.0.1:3000/three | tail -1
	http://127.0.0.1:3000/none

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
