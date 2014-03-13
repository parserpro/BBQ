package BBQ::Tags::center;
use common::sense;

sub open {
    my $self = shift;
    $self->{out} .= '<p style="text-align: center">';
    $self->{in}->{center}++;
}

sub close {
    my $self = shift;
    return unless $self->{in}->{center};
    $self->{out} .= '</p>';
    $self->{in}->{center}--;
}

1;