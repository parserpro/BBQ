package BBQ::Formats;
use common::sense;

our %formats = (
    default => [qw(b)],
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