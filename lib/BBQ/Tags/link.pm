package BBQ::Tags::link;
use common::sense;

=head1 NAME

BBQ::Tags::link

=head1 VERSION

Version 0.01

=head2 open
=cut

sub open {
    my ( $self, $arg ) = @_;
    $arg = substr($arg, 1) if index($arg, '/') == 0;
    $self->{out} .= qq{<a href="/$arg"$self->{extra}->{links_class}>};
    $self->{in}->{link}++;
    1;
}

=head2 close
=cut

sub close {
    my $self = shift;
    return unless $self->{in}->{link};
    $self->{out} .= '</a>';
    $self->{in}->{link}--;
}

1;