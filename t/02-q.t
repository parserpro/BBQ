#!perl -T
use 5.010;
use strict;
use warnings FATAL => 'all';
use utf8;
use Test::More;

plan tests => 2;

use_ok( 'BBQ' ) || print "Bail out!\n";

my $text = 'pre [q=Author]text[/q] past';
my $bbq = BBQ->new;
my $out = $bbq->parse($text);
is($out, 'pre <blockquote class="quote"><p>цитата <cite>author</cite></p><div>text</div></blockquote> past', 'Simple [p]');
