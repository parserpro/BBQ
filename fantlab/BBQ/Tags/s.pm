package BBQ::Tags::s;
use common::sense;

sub open {
    my $self = shift;
    $self->{out} .= '<s>';
    $self->{in}->{s}++;
}

sub close {
    my $self = shift;
    return unless $self->{in}->{s};
    $self->{out} .= '</s>';
    $self->{in}->{s}--;
}

1;