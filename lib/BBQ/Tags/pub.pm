package BBQ::Tags::pub;
use common::sense;

=head1 NAME

BBQ::Tags::pub

=head1 VERSION

Version 0.01

=head2 open
=cut

sub open {
    my ( $self, $arg ) = @_;
    $self->{out} .= qq{<a href="/publisher$arg"$self->{extra}->{links_class}>};
    $self->{in}->{pub}++;
    1;
}

=head2 close
=cut

sub close {
    my $self = shift;
    return unless $self->{in}->{pub};
    $self->{out} .= '</a>';
    $self->{in}->{pub}--;
}

1;