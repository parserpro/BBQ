#!perl -T
use 5.010;
use strict;
use warnings FATAL => 'all';
use Test::More;

plan tests => 2;

use_ok( 'BBQ' ) || print "Bail out!\n";

my $text = 'pre [left]bold[/left] past';
my $bbq = BBQ->new;
my $out = $bbq->parse($text);
is($out, 'pre <p style="text-align: left">bold</p> past', 'Simple [left]');
