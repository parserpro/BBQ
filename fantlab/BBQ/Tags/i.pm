package BBQ::Tags::i;
use common::sense;

=head1 NAME

BBQ::Tags::i

=head1 VERSION

Version 0.01

=head2 open
=cut

sub open {
    my $self = shift;
    $self->{out} .= '<i>';
    $self->{in}->{i}++;
    1;
}

=head2 close
=cut

sub close {
    my $self = shift;
    return unless $self->{in}->{i};
    $self->{out} .= '</i>';
    $self->{in}->{i}--;
}

1;