package BBQ::Tags::url;
use common::sense;

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
}

sub close {
    my $self = shift;
    return unless $self->{in}->{url};
    $self->{out} .= '</a>';
    $self->{in}->{url}--;
}

1;