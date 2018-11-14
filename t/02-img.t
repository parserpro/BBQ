#!perl -T
use 5.010;
use strict;
use warnings FATAL => 'all';
use Test::More;
use utf8;

plan tests => 4;

use_ok( 'BBQ' ) || print "Bail out!\n";

my $text = 'pre [img]http://server/image.file[/img] past';
my $bbq = BBQ->new;
my $out = $bbq->parse($text);
is($out, 'pre <img src="http://server/image.file" class="adaptimg" alt=""/> past', 'Simple [img]href[\img]');

$bbq->default;
$text = 'pre [img=http://server/image.file] past';
$out = $bbq->parse($text);
is($out, 'pre <img src="http://server/image.file" class="adaptimg" alt=""/> past', 'Simple [img=href]');

$bbq->default;
$text = 'pre [img=http://server/image."file] past';
$out = $bbq->parse($text);
isnt($out, 'pre <img src="http://server/image."file" alt="" /> past', 'Bad [img]');
