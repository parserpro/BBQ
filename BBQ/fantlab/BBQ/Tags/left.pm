package BBQ::Tags::left;
use common::sense;

sub open {
    my $self = shift;
    $self->{out} .= '<p style="text-align: left">';
    $self->{in}->{left}++;
}

sub close {
    my $self = shift;
    return unless $self->{in}->{left};
    $self->{out} .= '</p>';
    $self->{in}->{left}--;
}

1;