package BBQ::Tags::big;
use common::sense;

sub open {
    my $self = shift;
    $self->{out} .= '<b>';
    $self->{in}->{big}++;
    1;
}

sub close {
    my $self = shift;
    return unless $self->{in}->{big};
    $self->{out} .= '</b>';
    $self->{in}->{big}--;
}

1;