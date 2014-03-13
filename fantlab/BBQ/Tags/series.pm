package BBQ::Tags::series;
use common::sense;

sub open {
    my ( $self, $arg ) = @_;
    $self->{out} .= qq{<a href="/series$arg">};
    $self->{in}->{series}++;
}

sub close {
    my $self = shift;
    return unless $self->{in}->{series};
    $self->{out} .= '</a>';
    $self->{in}->{series}--;
}

1;