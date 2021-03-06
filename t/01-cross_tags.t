#!perl -T
use 5.010;
use strict;
use warnings FATAL => 'all';
use Test::More;
use utf8;

plan tests => 7;

use_ok( 'BBQ' ) || print "Bail out!\n";

my $text = '0[b]1[i]2[/b]3';
my $bbq = BBQ->new;
my $out = $bbq->parse($text);
is($out, '0<strong>1<i>2</i></strong>3', 'autoclose tags without interfere');


$bbq->default;
$out = $bbq->parse('1[b]2[b]3[i]4[/b]5');
is($out, '1<strong>2<strong>3<i>4</i></strong>5</strong>', 'autoclose tags without interfere - 2');

my $text2 = '[b][b]1[i]2[u]3[/b]4';
$bbq->default;
$out = $bbq->parse($text2);
is($out, '<strong><strong>1<i>2<span style="text-decoration: underline">3</span></i></strong>4</strong>', 'pre path test');

my $text3 = '1[/b]2';
$bbq->default;
$out = $bbq->parse($text3);
is($out, '1[/b]2', 'unbalanced close tag');

my $text4 = '[b][u]123[/b][/u]';
$bbq->default;
$out = $bbq->parse($text4);
is($out, '<strong><span style="text-decoration: underline">123</span></strong>[/u]', 'crossed tags');

my $text5 = '[b][u]123[/b][/u]';
$bbq->default(leave => 0);
$out = $bbq->parse($text5);
is($out, '<strong><span style="text-decoration: underline">123</span></strong>', 'crossed tags (leave = 0)');

