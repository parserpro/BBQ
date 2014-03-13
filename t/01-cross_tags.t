#!perl -T
use 5.010;
use strict;
use warnings FATAL => 'all';
use Test::More;
use Data::Dumper;

plan tests => 5;

use_ok( 'BBQ' ) || print "Bail out!\n";

my $text = '0[b]1[i]2[/b]3';
my $bbq = BBQ->new;
my $out = $bbq->parse($text);
is($out, '0<strong>1<i>2</i></strong>3', 'autoclose tags without interfere');


$bbq->default;
$out = $bbq->parse('1[b]2[b]3[i]4[/b]5');
is($out, '1<strong>2<strong>3<i>4</i></strong>5</strong>', 'autoclose tags without interfere - 2');

warn "2 ======================================================\n";
my $text2 = '[b][b]1[i]2[u]3[/b]4';
$bbq->default;
$out = $bbq->parse($text2);
is($out, '<strong><strong>1<i>2<span style="text-decoration: underline">3</span></i></strong>4</strong>', 'pre path test');

warn "3 ======================================================\n";
my $text3 = '1[/b]2';
$bbq->default;
$out = $bbq->parse($text3);
is($out, '<strong>1<i>2<span style="text-decoration: underline">3</span></i></strong>4</strong>', 'unbalanced close tag');
