package BBQ::Tags::code;
use common::sense;

=head1 NAME

BBQ::Tags::code

=head1 VERSION

Version 0.01

=head2 open
=cut

sub open {
    my $self = shift;
    $self->{out} .= '<pre>';
    $self->{in}->{code}++;
    1;
}

=head2 close
=cut

sub close {
    my $self = shift;
    return unless $self->{in}->{code};
    $self->{out} .= '</pre>';
    $self->{in}->{code}--;
}

1;