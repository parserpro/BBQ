#!perl -T
use 5.010;
use strict;
use warnings FATAL => 'all';
use Test::More;

plan tests => 4;

use_ok( 'BBQ' ) || print "Bail out!\n";

my $text = 'pre [size=30]bold[/size] past';
my $bbq = BBQ->new;
my $out = $bbq->parse($text);
is($out, 'pre <span style="font-size:30%;">bold</span> past', 'Simple [size]');

$bbq->default;
$text = 'pre [size=0]bold[/size] past';
$out = $bbq->parse($text);
isnt($out, 'pre <span style="font-size:0%;">bold</span> past', 'Wrong size 0');

$bbq->default;
$text = 'pre [size=300]bold[/size] past';
$out = $bbq->parse($text);
isnt($out, 'pre <span style="font-size:300%;">bold</span> past', 'Wrong size 300');
