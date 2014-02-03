package BBQ::Tags::edition;
use common::sense;

sub open {
    my ( $self, $arg ) = @_;
    $self->{out} .= qq{<a href="/edition$arg">};
    $self->{in}->{edition}++;
}

sub close {
    my $self = shift;
    return unless $self->{in}->{edition};
    $self->{out} .= '</a>';
    $self->{in}->{edition}--;
}

1