#!perl -T
use 5.010;
use strict;
use warnings FATAL => 'all';
use utf8;
use Test::More;

plan tests => 2;

use_ok( 'BBQ' ) || print "Bail out!\n";

my $text = 'pre [spoiler]тайна[/spoiler] past';
my $bbq = BBQ->new;
my $out = $bbq->parse($text);
is($out, q~pre <div style="margin:5px"><small><b>Спойлер (раскрытие сюжета)<\/b> <font color="#606060">(кликните по нему, чтобы увидеть)<\/font><\/small><br><div class="h" onClick="if(this.style.color=='black'){this.style.color='F9FAFB'}else{this.style.color='black'}">[spoiler]тайна[/spoiler] past~, 'Simple [spoiler]');
