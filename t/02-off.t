#!perl -T
use 5.010;
use strict;
use warnings FATAL => 'all';
use Test::More;
use utf8;

plan tests => 2;

use_ok( 'BBQ' ) || print "Bail out!\n";

my $text = 'text [br] [off] pre [br] off [/off] ttt [br] past';
my $bbq = BBQ->new;
my $out = $bbq->parse($text);
is($out, 'text <br>  pre [br] off  ttt <br> past', 'Temporary turn BBQ off');
