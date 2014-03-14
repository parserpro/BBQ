package BBQ::Formats;
use common::sense;

=head1 NAME

BBQ::Formats

=head1 VERSION

Version 0.01

=cut

our %formats = (
    default => [qw(b i u color * list)],
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