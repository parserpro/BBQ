package BBQ::Formats;
use common::sense;

=head1 NAME

BBQ::Tags::_asteriks

=head1 VERSION

Version 0.01
=cut

our %formats = (
    default => [qw(* art article autor award b center code color contest dictor edition film genre h i img left link list
                   news p pub q right s series size spoiler subtitle translator u url user work work_t)],
    message => [qw(* art article autor award b center compl contest dictor edition film h i left link list news
                   p pub right s series spoiler translator u url user video work)],
    news    => [qw(* art article autor award b center compl contest dictor edition film h i left link list news
                   p pub right s series spoiler translator u url user video work print_contest)],
    blog    => [qw(* art article autor award b center compl contest dictor edition film h i left link list news
                   p pub right s series spoiler translator u url user video work
                   print_contest subtitle hr big)],
    new     => [qw(code color q size)],
);

=head2 full_set
=cut

sub full_set {
    my %tags;

    while ( my ($k, $v) = each %formats ) {
        for ( @$v ) {
            $tags{$_} = 1;
        };
    }

    return keys %tags;
}

1;