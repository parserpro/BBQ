#!perl -T
use 5.010;
use strict;
use warnings FATAL => 'all';
use Test::More;

plan tests => 2;

use_ok( 'BBQ' ) || print "Bail out!\n";

my $text = 'pre [url=http://wiki.naszabiblioteczka.pl/index.php?title=Paweł_Laudański]Paweł_Laudański[/url] past';
my $bbq = BBQ->new;
my $out = $bbq->parse($text);
is($out, 'pre <a href="http://wiki.naszabiblioteczka.pl/index.php?title=Paweł_Laudański" rel="nofollow" target="_blank">Paweł_Laudański</a> past', 'Simple [url]');
