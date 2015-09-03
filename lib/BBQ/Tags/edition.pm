package BBQ::Tags::edition;
use common::sense;

=head1 NAME

BBQ::Tags::edition

=head1 VERSION

Version 0.01

=head2 open
=cut

sub open {
    my ( $self, $arg ) = @_;
    $self->{out} .= qq{<a href="/edition$arg"$self->{extra}->{links_class}>};
    $self->{in}->{edition}++;
    1;
}

=head2 close
=cut

sub close {
    my $self = shift;
    return unless $self->{in}->{edition};
    $self->{out} .= '</a>';
    $self->{in}->{edition}--;
}

1