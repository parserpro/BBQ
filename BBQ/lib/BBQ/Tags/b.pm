package BBQ::Tags::b;
use common::sense;

sub open {
    my $self = shift;
    $self->{out} .= '<strong>';
    $self->{in}->{b}++;
}

sub close {
    my $self = shift;
    return unless $self->{in}->{b};
    $self->{out} .= '</strong>';
    $self->{in}->{b}--;
}

1;