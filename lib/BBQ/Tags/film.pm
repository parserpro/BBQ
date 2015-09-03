package BBQ::Tags::film;
use common::sense;

=head1 NAME

BBQ::Tags::film

=head1 VERSION

Version 0.01

=head2 open
=cut

sub open {
    my ( $self, $arg ) = @_;
    $self->{out} .= qq{<a href="/film$arg"$self->{extra}->{links_class}>};
    $self->{in}->{film}++;
    1;
}

=head2 close
=cut

sub close {
    my $self = shift;
    return unless $self->{in}->{film};
    $self->{out} .= '</a>';
    $self->{in}->{film}--;
}

1;