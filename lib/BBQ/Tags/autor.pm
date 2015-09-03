package BBQ::Tags::autor;
use common::sense;

=head1 NAME

BBQ::Tags::autor

=head1 VERSION

Version 0.01

=head2 open
=cut

sub open {
    my ( $self, $arg ) = @_;
    $self->{out} .= qq{<a href="/autor$arg"$self->{extra}->{links_class}>};
    $self->{in}->{autor}++;
    1;
}

=head2 close
=cut

sub close {
    my $self = shift;
    return unless $self->{in}->{autor};
    $self->{out} .= '</a>';
    $self->{in}->{autor}--;
}

1;
