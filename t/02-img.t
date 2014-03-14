#!perl -T
use 5.010;
use strict;
use warnings FATAL => 'all';
use Test::More;

plan tests => 4;

use_ok( 'BBQ' ) || print "Bail out!\n";

my $text = 'pre [img]http://server/image.file[/img] past';
my $bbq = BBQ->new;
my $out = $bbq->parse($text);
is($out, 'pre <img src="http://server/image.file" alt="" /> past', 'Simple [img]');

$bbq->default;
$text = 'pre [img=http://server/image.file] past';
$out = $bbq->parse($text);
is($out, 'pre <img src="http://server/image.file" alt="" /> past', 'Simple [img]');

$bbq->default;
$text = 'pre [img=http://server/image."file] past';
$out = $bbq->parse($text);
isnt($out, 'pre <img src="http://server/image."file" alt="" /> past', 'Simple [img]');
