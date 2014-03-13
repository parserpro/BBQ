package BBQ::Tags::i;
use common::sense;

sub open {
    my $self = shift;
    $self->{out} .= '<i>';
    $self->{in}->{i}++;
}

sub close {
    my $self = shift;
    return unless $self->{in}->{i};
    $self->{out} .= '</i>';
    $self->{in}->{i}--;
}

1;