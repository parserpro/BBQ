#!perl -T
use 5.010;
use strict;
use warnings FATAL => 'all';
use Test::More;
use utf8;

plan tests => 2;

use_ok( 'BBQ' ) || print "Bail out!\n";

my $text = 'pre [code=Примерчик]<xml> [comment][b]test[/b][/code] past';
my $bbq = BBQ->new;
my $out = $bbq->parse($text);
is($out, 'pre <fieldset class="quote pre"><legend>Примерчик</legend>&lt;xml&gt; &#091;comment&#093;&#091;b&#093;test&#091;/b&#093;</fieldset> past', 'Simple [code]');
