package BBQ::Tags::pub;
use common::sense;

sub open {
    my ( $self, $arg ) = @_;
    $self->{out} .= qq{<a href="/publisher$arg">};
    $self->{in}->{pub}++;
}

sub close {
    my $self = shift;
    return unless $self->{in}->{pub};
    $self->{out} .= '</a>';
    $self->{in}->{pub}--;
}

1;