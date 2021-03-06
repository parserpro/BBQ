package BBQ::Tags::u;
use common::sense;

our @alias = qw(u1);

=head1 NAME

BBQ::Tags::u

=head1 VERSION

Version 0.01

=head2 open
=cut

sub open {
    my $self = shift;
    $self->{out} .= '<span style="text-decoration: underline">';
    $self->{in}->{u}++;
    1;
}

=head2 close
=cut

sub close {
    my $self = shift;
    return unless $self->{in}->{u};
    $self->{out} .= '</span>';
    $self->{in}->{u}--;
}

1;
