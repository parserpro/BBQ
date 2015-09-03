package BBQ::Tags::series;
use common::sense;

=head1 NAME

BBQ::Tags::series

=head1 VERSION

Version 0.01

=head2 open
=cut

sub open {
    my ( $self, $arg ) = @_;
    $self->{out} .= qq{<a href="/series$arg"$self->{extra}->{links_class}>};
    $self->{in}->{series}++;
    1;
}

=head2 close
=cut

sub close {
    my $self = shift;
    return unless $self->{in}->{series};
    $self->{out} .= '</a>';
    $self->{in}->{series}--;
}

1;