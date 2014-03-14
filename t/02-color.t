#!perl -T
use 5.010;
use strict;
use warnings FATAL => 'all';
use Test::More;

plan tests => 5;

use_ok( 'BBQ' ) || print "Bail out!\n";

my $text = 'pre [color=red]bold[/color] past';
my $bbq = BBQ->new;
my $out = $bbq->parse($text);
is($out, 'pre <span style="color:red">bold</span> past', 'Simple [color]');

$bbq->default;
$text = 'pre [color=rod]bold[/color] past';
$out = $bbq->parse($text);
isnt($out, 'pre <span style="color:red">bold</span> past', 'not processed wrong color');
is($out, 'pre [color=rod]bold[/color] past', 'not processed wrong color 2');

$bbq->default;
$text = 'pre [color=#1122bb]bold[/color] past';
$out = $bbq->parse($text);
is($out, 'pre <span style="color:#1122bb">bold</span> past', 'processed HEX color');

