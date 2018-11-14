package BBQ::Tags::off;
use common::sense;

=head1 NAME

BBQ::Tags::off

=head1 VERSION

Version 0.01

=head2 open
=cut

sub open {
    my ( $self, $name ) = @_;
    warn "=== running off::open" if $self->{debug};
    $self->off;
    $self->{in}->{off}++;
    1;
}

=head2 close
=cut

sub close {
    my $self = shift;
    warn "=== running off::close" if $self->{debug};
    return unless $self->{in}->{off};
    $self->{in}->{off}--;
    $self->on;
    1;
}

1;