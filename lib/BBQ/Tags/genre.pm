package BBQ::Tags::genre;
use common::sense;

=head1 NAME

BBQ::Tags::genre

=head1 VERSION

Version 0.01

=head2 open
=cut

sub open {
    my $self = shift;
    $self->{out} .= '<i>Жанр: ';
    $self->{in}->{genre}++;
    1;
}

=head2 close
=cut

sub close {
    my $self = shift;
    return unless $self->{in}->{genre};
    $self->{out} .= '</i>';
    $self->{in}->{genre}--;
}

1;