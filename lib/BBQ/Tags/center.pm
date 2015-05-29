package BBQ::Tags::center;
use common::sense;

=head1 NAME

BBQ::Tags::center

=head1 VERSION

Version 0.01

=head2 open
=cut

sub open {
    my $self = shift;
    $self->{out} .= '<center>';
    $self->{in}->{center}++;
    1;
}

=head2 close
=cut

sub close {
    my $self = shift;
    return unless $self->{in}->{center};
    $self->{out} .= '</center>';
    $self->{in}->{center}--;
}

1;