package BBQ::Tags::news;
use common::sense;

=head1 NAME

BBQ::Tags::news

=head1 VERSION

Version 0.01

=head2 open
=cut

sub open {
    my ( $self, $arg ) = @_;
    $self->{out} .= qq{<a href="/news$arg"$self->{extra}->{links_class}>};
    $self->{in}->{news}++;
    1;
}

=head2 close
=cut

sub close {
    my $self = shift;
    return unless $self->{in}->{news};
    $self->{out} .= '</a>';
    $self->{in}->{news}--;
}

1;