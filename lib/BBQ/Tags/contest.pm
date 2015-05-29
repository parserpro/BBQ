package BBQ::Tags::contest;
use common::sense;

sub open {
    my ( $self, $arg ) = @_;
    $self->{out} .= qq{<a href="/contest$arg">};
    $self->{in}->{contest}++;
    1;
}

sub close {
    my $self = shift;
    return unless $self->{in}->{contest};
    $self->{out} .= '</a>';
    $self->{in}->{contest}--;
}

1;