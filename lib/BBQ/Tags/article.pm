package BBQ::Tags::article;
use common::sense;

=head1 NAME

BBQ::Tags::article

=head1 VERSION

Version 0.01

=head2 open
=cut

sub open {
    my ( $self, $arg ) = @_;
    $self->{out} .= qq{<a href="/article$arg"$self->{extra}->{links_class}>};
    $self->{in}->{article}++;
    1;
}

=head2 close
=cut

sub close {
    my $self = shift;
    return unless $self->{in}->{article};
    $self->{out} .= '</a>';
    $self->{in}->{article}--;
}

1;