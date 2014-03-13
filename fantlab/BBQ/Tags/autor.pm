package BBQ::Tags::autor;
use common::sense;

sub open {
    my ( $self, $arg ) = @_;
    $self->{out} .= qq{<a href="/autor$arg">};
    $self->{in}->{autor}++;
}

sub close {
    my $self = shift;
    return unless $self->{in}->{autor};
    $self->{out} .= '</a>';
    $self->{in}->{autor}--;
}

1;