package BBQ::Tags::p;
use common::sense;

=head1 NAME

BBQ::Tags::p

=head1 VERSION

Version 0.01

=head2 open
=cut

sub open {
    my $self = shift;
    $self->{out} .= '<p>';
    $self->{in}->{p}++;
    1;
}

=head2 close
=cut

sub close {
    my $self = shift;
    return unless $self->{in}->{p};
    $self->{out} .= '</p>';
    $self->{in}->{p}--;
}

1;