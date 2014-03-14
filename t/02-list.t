#!perl -T
use 5.010;
use strict;
use warnings FATAL => 'all';
use Test::More;

plan tests => 4;

use_ok( 'BBQ' ) || print "Bail out!\n";

my $text = 'pre [list][*]1[*]2[*]3[/list] past';
my $bbq = BBQ->new;
my $out = $bbq->parse($text);
is($out, 'pre <ol style="list-style-type: disc;"><li>1</li><li>2</li><li>3</li></ol> past', 'Simple [list]');

$bbq->default;
$text = 'pre [list][*]1[*]2[list][*]2.1[*]2.2[/list][*]3[/list] past';
$out = $bbq->parse($text);
is($out, 'pre <ol style="list-style-type: disc;"><li>1</li><li>2<ol style="list-style-type: disc;"><li>2.1</li><li>2.2</li></ol></li><li>3</li></ol> past', 'Nested [list]');

$bbq->default;
$text = 'pre [list=1][*]1[*]2[/list] past';
$out = $bbq->parse($text);
is($out, 'pre <ol style="list-style-type: decimal;"><li>1</li><li>2</li></ol> past', 'Numbered [list]');
