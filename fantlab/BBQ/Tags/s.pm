package BBQ::Tags::s;
use common::sense;

=head1 NAME

BBQ::Tags::s

=head1 VERSION

Version 0.01

=head2 open
=cut

sub open {
    my $self = shift;
    $self->{out} .= '<span style="text-decoration:line-through;">';
    $self->{in}->{s}++;
    1;
}

=head2 close
=cut

sub close {
    my $self = shift;
    return unless $self->{in}->{s};
    $self->{out} .= '</span>';
    $self->{in}->{s}--;
}

1;
