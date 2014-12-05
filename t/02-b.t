#!perl -T
use 5.010;
use strict;
use warnings FATAL => 'all';
use Test::More;
use utf8;

plan tests => 5;

use_ok( 'BBQ' ) || print "Bail out!\n";

{
    my $text = 'pre [b]bold[/b] past';
    my $bbq = BBQ->new;
    my $out = $bbq->parse($text);
    is($out, 'pre <strong>bold</strong> past', 'Simple [b]');
}

{
    my $text = 'pre [b]bold[/b] past';
    my $bbq = BBQ->new( set => ['b']);
    my $out = $bbq->parse($text);
    is($out, 'pre <strong>bold</strong> past', 'Simple [b] with set');
}

{
    my $text = 'pre [b]bold[/b] past';
    my $bbq = BBQ->new( set => ['fake_tag']);
    my $out = $bbq->parse($text);
    isnt($out, 'pre <strong>bold</strong> past', 'Simple [b] with fake set');
    is  ($out, 'pre [b]bold[/b] past', 'Simple [b] with fake set');
}