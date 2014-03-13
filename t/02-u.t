#!perl -T
use 5.010;
use strict;
use warnings FATAL => 'all';
use Test::More;

plan tests => 5;

use_ok( 'BBQ' ) || print "Bail out!\n";

{
    my $text = 'pre [u]bold[/u] past';
    my $bbq = BBQ->new;
    my $out = $bbq->parse($text);
    is($out, 'pre <span style="text-decoration: underline">bold</span> past', 'Simple [u]');
}

{
    my $text = 'pre [u]bold[/u] past';
    my $bbq = BBQ->new( set => ['u']);
    my $out = $bbq->parse($text);
    is($out, 'pre <span style="text-decoration: underline">bold</span> past', 'Simple [u] with set');
}

{
    my $text = 'pre [u]bold[/u] past';
    my $bbq = BBQ->new( set => ['fake_tag']);
    my $out = $bbq->parse($text);
    isnt($out, 'pre <span style="text-decoration: underline">bold</span> past', 'Simple [u] with fake set');
    is  ($out, 'pre [u]bold[/u] past', 'Simple [u] with fake set');
}
