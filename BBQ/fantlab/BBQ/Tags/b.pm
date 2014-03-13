package BBQ::Tags::b;
use common::sense;

sub open {
    my $self = shift;
    $self->{out} .= '<b>';
    $self->{in}->{b}++;
}

sub close {
    my $self = shift;
    return unless $self->{in}->{b};
    $self->{out} .= '</b>';
    $self->{in}->{b}--;
}

1;