package BBQ::Tags::edition;
use common::sense;

sub open {
    my ( $self, $arg ) = @_;
    $self->{out} .= qq{<a href="/edition$arg"$self->{extra}->{links_class}>};
    $self->{in}->{edition}++;
    1;
}

sub close {
    my $self = shift;
    return unless $self->{in}->{edition};
    $self->{out} .= '</a>';
    $self->{in}->{edition}--;
}

1