package BBQ::Tags::genre;
use common::sense;

sub open {
    my $self = shift;
    $self->{out} .= '<i>Жанр: ';
    $self->{in}->{genre}++;
    1;
}

sub close {
    my $self = shift;
    return unless $self->{in}->{genre};
    $self->{out} .= '</i>';
    $self->{in}->{genre}--;
}

1;