package BBQ::Tags::news;
use common::sense;

sub open {
    my ( $self, $arg ) = @_;
    $self->{out} .= qq{<a href="/news$arg">};
    $self->{in}->{news}++;
}

sub close {
    my $self = shift;
    return unless $self->{in}->{news};
    $self->{out} .= '</a>';
    $self->{in}->{news}--;
}

1;