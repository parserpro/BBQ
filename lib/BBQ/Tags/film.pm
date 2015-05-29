package BBQ::Tags::film;
use common::sense;

sub open {
    my ( $self, $arg ) = @_;
    $self->{out} .= qq{<a href="/film$arg">};
    $self->{in}->{film}++;
    1;
}

sub close {
    my $self = shift;
    return unless $self->{in}->{film};
    $self->{out} .= '</a>';
    $self->{in}->{film}--;
}

1;