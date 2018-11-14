#!perl
use 5.010;
use strict;
use warnings FATAL => 'all';
use Test::More;
use utf8;

unless ( $ENV{MOJO_HOME} ) {
    plan( skip_all => "Not a FantLab installation" );
}


use Fantlab::CLI;

plan tests => 2;

use_ok( 'BBQ' ) || print "Bail out!\n";

my $text = 'pre [LIST][*]Стивен Кинг. [work_t=403:125]Колдун и кристалл[/work][/LIST] post';
my $bbq = BBQ->new(debug => 0);
my $out = $bbq->parse($text);
is($out, 'pre <ol style="list-style-type: disc;"><li>Стивен Кинг. <span class="fantlab work_403" data-fantlab_type="work" data-fantlab_id="403"><a href="/work403">Колдун и кристалл</a></span> (роман, перевод <a class="agray" href="/translator125">С. Сухинова</a>)</li></ol> post');
