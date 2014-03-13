#!perl -T
use 5.010;
use strict;
use warnings FATAL => 'all';
use Test::More;
use Data::Dumper;

plan tests => 8;

use_ok( 'BBQ' ) || print "Bail out!\n";

my $text = '[b]1[b]2[b]3[/b]4[/b]5[/b]';
my $bbq = BBQ->new;
my $out = $bbq->parse($text);
is($out, '<strong>1<strong>2<strong>3</strong>4</strong>5</strong>', 'pre path test');
is_deeply( $bbq->{path}, [], 'balanced path test');


my $text2 = '[b]1[b]2[b]3[/b]4[/b]5';
$bbq->default;
my $out2 = $bbq->parse($text2);
is($out2, '<strong>1<strong>2<strong>3</strong>4</strong>5</strong>', 'pre path test');
is_deeply( $bbq->{path}, [], 'unbalanced path test');


my $text3 = '[b]1[c]2[d]';
$bbq->default;
my $out3 = $bbq->parse($text3);
is($out3, '<strong>1[c]2[d]</strong>', 'pre path test');
is_deeply( $bbq->{path}, [], 'unbalanced path test with wrong tags');
is_deeply( $bbq->{in}, {'b' => 0}, 'unbalanced path test with wrong tags - "in" counter');
