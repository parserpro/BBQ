package BBQ::Tags::u;
use common::sense;

sub open {
    my $self = shift;
    $self->{out} .= '<u>';
    $self->{in}->{u}++;
}

sub close {
    my $self = shift;
    return unless $self->{in}->{u};
    $self->{out} .= '</u>';
    $self->{in}->{u}--;
}

1;