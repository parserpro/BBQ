package BBQ::Tags::award;
use common::sense;

sub open {
    my ( $self, $arg ) = @_;
    $self->{out} .= qq{<a href="/award$arg">};
    $self->{in}->{award}++;
}

sub close {
    my $self = shift;
    return unless $self->{in}->{award};
    $self->{out} .= '</a>';
    $self->{in}->{award}--;
}

1;