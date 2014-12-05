#!perl -T
use 5.010;
use strict;
use warnings FATAL => 'all';
use Test::More;
use utf8;

plan tests => 2;

use_ok( 'BBQ' ) || print "Bail out!\n";

my $text = 'pre [right]bold[/right] past';
my $bbq = BBQ->new;
my $out = $bbq->parse($text);
is($out, 'pre <p style="text-align: right">bold</p> past', 'Simple [right]');
