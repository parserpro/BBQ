#!perl -T
use 5.010;
use strict;
use warnings FATAL => 'all';
use Test::More;

plan tests => 3;

use_ok( 'BBQ' ) || print "Bail out!\n";

my $text = 'pre [list][*]1[*]2[*]3[/list] past';
my $bbq = BBQ->new;
my $out = $bbq->parse($text);
is($out, 'pre <ul><li>1</li><li>2</li><li>3</li></ul> past', 'Simple [list]');

$bbq->default;
$text = 'pre [list][*]1[*]2[list][*]2.1[*]2.2[/list][*]3[/list] past';
$out = $bbq->parse($text);
is($out, 'pre <ul><li>1</li><li>2<ul><li>2.1</li><li>2.2</li></ul></li><li>3</li></ul> past', 'Nested [list]');
