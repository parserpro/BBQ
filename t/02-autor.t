#!perl -T
use 5.010;
use strict;
use warnings FATAL => 'all';
use Test::More;
use utf8;

plan tests => 3;

use_ok( 'BBQ' ) || print "Bail out!\n";

my $bbq = BBQ->new;

my $text = 'pre [autor=1234]Paweł_Laudański[/autor] past';
my $out = $bbq->parse($text);
is($out, 'pre <a href="/autor1234">Paweł_Laudański</a> past', 'Simple [url]');

$out = $bbq->parse($text, extra => {links_class => ' class="gray"'});
is($out, 'pre <a href="/autor1234" class="gray">Paweł_Laudański</a> past', 'Simple [url]');
