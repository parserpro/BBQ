package BBQ::Tags::b;
use common::sense;

=head1 NAME

BBQ::Tags::b

=head1 VERSION

Version 0.01

=head2 open
=cut

sub open {
    my $self = shift;
    $self->{out} .= '<strong>';
    $self->{in}->{b}++;
    1;
}

=head2 close
=cut

sub close {
    my $self = shift;
    return unless $self->{in}->{b};
    $self->{out} .= '</strong>';
    $self->{in}->{b}--;
}

1;