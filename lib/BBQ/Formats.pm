package BBQ::Formats;
use common::sense;

=head1 NAME

BBQ::Formats

=head1 VERSION

Version 0.01

=cut

our %formats = (
    default => [qw(b i u color * list size center img left right a s d)],
);

=head2 full_set

sub full_set {
    my %tags;

    while ( my ($k, $v) = each %formats ) {
        for ( @$v ) {
            $tags{$_} = 1;
        };
    }

    return keys %tags;
}

=cut

1;