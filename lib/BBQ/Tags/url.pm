package BBQ::Tags::url;
use common::sense;

=head1 NAME

BBQ::Tags::b

=head1 VERSION

Version 0.01

=head2 open
=cut

sub open {
    my ( $self, $arg ) = @_;

    if ( $arg =~ /^(?:http:\/\/)?(?:www\.)?fantlab\.ru(.+)$/ ) {
        $self->{out} .= qq~<a href="$1">~;
        $self->{in}->{url}++;
    }
    else {
        $self->{out} .= qq{<a href="$arg" rel="nofollow" target="_blank">};
        $self->{in}->{url}++;
    }

    1;
}

=head2 close
=cut

sub close {
    my $self = shift;
    return unless $self->{in}->{url};
    $self->{out} .= '</a>';
    $self->{in}->{url}--;
}

1;