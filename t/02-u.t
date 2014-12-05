#!perl -T
use 5.010;
use strict;
use warnings FATAL => 'all';
use Test::More;
use utf8;

plan tests => 6;

use_ok( 'BBQ' ) || print "Bail out!\n";

my $text = 'pre [u]bold[/u] past';
my $bbq = BBQ->new;
my $out = $bbq->parse($text);
is($out, 'pre <span style="text-decoration: underline">bold</span> past', 'Simple [u]');

$text = 'pre [u]bold[/u] past';
$bbq = BBQ->new( set => ['u']);
$out = $bbq->parse($text);
is($out, 'pre <span style="text-decoration: underline">bold</span> past', 'Simple [u] with set');

$text = 'pre [u]bold[/u] past';
$bbq = BBQ->new( set => ['fake_tag']);
$out = $bbq->parse($text);
isnt($out, 'pre <span style="text-decoration: underline">bold</span> past', 'Simple [u] with fake set');
is  ($out, 'pre [u]bold[/u] past', 'Simple [u] with fake set');

$bbq = BBQ->new( set => ['u1']);
$text = '[u1]1[/u1]';
$out  = $bbq->parse($text);
is($out, '<span style="text-decoration: underline">1</span>', '[u] alias');
