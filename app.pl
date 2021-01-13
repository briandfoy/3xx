use v5.28;
use Mojolicious::Lite;

use experimental qw(signatures);

get '/none' => sub ( $c ) {
	$c->render( text => "This is the end. My friend the end." );
	};

get '/one' => sub ( $c ) {
	$c->redirect_to( $c->req->url->path( '/none' )->to_abs );
	};

get '/two' => sub ( $c ) {
	$c->redirect_to( $c->req->url->path( '/one' )->to_abs );
	};

get '/three' => sub ( $c ) {
	$c->redirect_to( $c->req->url->path( '/two' )->to_abs );
	};

app->start;
