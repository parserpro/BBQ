package BBQ::Tags::img;
use common::sense;

sub open {
    my $self = shift;
    $self->{in}->{img}++;
}

sub text {
    my ( $self, $text ) = @_;

    $self->{out} .= '<img src="' . $text . '" alt="" />';
}

sub close {
    my $self = shift;
    return unless $self->{in}->{img};
    $self->{in}->{i}--;
}

1;