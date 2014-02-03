package BBQ::Tags::p;
use common::sense;

sub open {
    my $self = shift;
    $self->{out} .= '<p>';
    $self->{in}->{p}++;
}

sub close {
    my $self = shift;
    return unless $self->{in}->{p};
    $self->{out} .= '</p>';
    $self->{in}->{p}--;
}

1;