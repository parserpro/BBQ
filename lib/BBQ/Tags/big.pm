package BBQ::Tags::big;
use common::sense;

=head1 NAME

BBQ::Tags::big

=head1 VERSION

Version 0.01

=head2 open
=cut

sub open {
    my $self = shift;
    $self->{out} .= '<b>';
    $self->{in}->{big}++;
    1;
}

=head2 close
=cut

sub close {
    my $self = shift;
    return unless $self->{in}->{big};
    $self->{out} .= '</b>';
    $self->{in}->{big}--;
}

1;