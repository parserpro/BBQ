package BBQ::Tags::left;
use common::sense;

=head1 NAME

BBQ::Tags::left

=head1 VERSION

Version 0.01

=head2 open
=cut

sub open {
    my $self = shift;
    $self->{out} .= '<p style="text-align: left">';
    $self->{in}->{left}++;
    1;
}

=head2 close
=cut

sub close {
    my $self = shift;
    return unless $self->{in}->{left};
    $self->{out} .= '</p>';
    $self->{in}->{left}--;
}

1;