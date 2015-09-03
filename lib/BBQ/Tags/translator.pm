package BBQ::Tags::translator;
use common::sense;

=head1 NAME

BBQ::Tags::translator

=head1 VERSION

Version 0.01

=head2 open
=cut

sub open {
    my ( $self, $arg ) = @_;
    $self->{out} .= qq{<a href="/translator$arg"$self->{extra}->{links_class}>};
    $self->{in}->{translator}++;
    1;
}

=head2 close
=cut

sub close {
    my $self = shift;
    return unless $self->{in}->{translator};
    $self->{out} .= '</a>';
    $self->{in}->{translator}--;
}

1;