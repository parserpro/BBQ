package BBQ::Tags::award;
use common::sense;

=head1 NAME

BBQ::Tags::award

=head1 VERSION

Version 0.01

=head2 open
=cut

sub open {
    my ( $self, $arg ) = @_;
    $self->{out} .= qq{<a href="/award$arg"$self->{extra}->{links_class}>};
    $self->{in}->{award}++;
    1;
}

=head2 close
=cut

sub close {
    my $self = shift;
    return unless $self->{in}->{award};
    $self->{out} .= '</a>';
    $self->{in}->{award}--;
}

1;