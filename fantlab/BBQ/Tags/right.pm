package BBQ::Tags::right;
use common::sense;

=head1 NAME

BBQ::Tags::right

=head1 VERSION

Version 0.01

=head2 open
=cut

sub open {
    my $self = shift;
    $self->{out} .= '<p style="text-align: right">';
    $self->{in}->{right}++;
    1;
}

=head2 close
=cut

sub close{
    my $self = shift;
    return unless $self->{in}->{right};
    $self->{out} .= '</p>';
    $self->{in}->{right}--;
}

1;
