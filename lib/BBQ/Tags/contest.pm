package BBQ::Tags::contest;
use common::sense;

=head1 NAME

BBQ::Tags::contest

=head1 VERSION

Version 0.01

=head2 open
=cut

sub open {
    my ( $self, $arg ) = @_;
    $self->{out} .= qq{<a href="/contest$arg"$self->{extra}->{links_class}>};
    $self->{in}->{contest}++;
    1;
}

=head2 close
=cut

sub close {
    my $self = shift;
    return unless $self->{in}->{contest};
    $self->{out} .= '</a>';
    $self->{in}->{contest}--;
}

1;