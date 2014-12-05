#!perl -T
use 5.010;
use strict;
use warnings FATAL => 'all';
use Test::More;
use utf8;

plan tests => 5;

use_ok( 'BBQ' ) || print "Bail out!\n";

{
    my $text = 'pre [i]bold[/i] past';
    my $bbq = BBQ->new;
    my $out = $bbq->parse($text);
    is($out, 'pre <i>bold</i> past', 'Simple [i]');
}

{
    my $text = 'pre [i]bold[/i] past';
    my $bbq = BBQ->new( set => ['i']);
    my $out = $bbq->parse($text);
    is($out, 'pre <i>bold</i> past', 'Simple [i] with set');
}

{
    my $text = 'pre [i]bold[/i] past';
    my $bbq = BBQ->new( set => ['fake_tag']);
    my $out = $bbq->parse($text);
    isnt($out, 'pre <i>bold</i> past', 'Simple [i] with fake set');
    is  ($out, 'pre [i]bold[/i] past', 'Simple [i] with fake set');
}
