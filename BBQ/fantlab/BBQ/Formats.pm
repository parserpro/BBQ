package BBQ::Formats;
use common::sense;

our %formats = (
    default => [qw(* art article autor award b center contest dictor edition film h i img left link list
                   news p pub right s series translator u url user work)],
    message => [qw(* art article autor award b center compl contest dictor edition film h i left link list news
                   p pub right s series spoiler translator u url user video work)],
    news    => [qw(* art article autor award b center compl contest dictor edition film h i left link list news
                   p pub right s series spoiler translator u url user video work print_contest)],
);

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