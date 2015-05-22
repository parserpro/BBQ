#!perl -T
use 5.010;
use strict;
use warnings FATAL => 'all';
use Test::More;
use utf8;

plan tests => 2;

use_ok( 'BBQ' ) || print "Bail out!\n";

my $text = 'pre [code=Примерчик]<xml> [comment][/code] past';
my $bbq = BBQ->new;
my $out = $bbq->parse($text);
is($out, 'pre <fieldset class="q pre"><legend>Примерчик</legend>&lt;xml&gt; [comment]</fieldset> past', 'Simple [code]');
