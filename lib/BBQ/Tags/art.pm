package BBQ::Tags::art;
use common::sense;

=head1 NAME

BBQ::Tags::art

=head1 VERSION

Version 0.01

=head2 open
=cut

sub open {
    my ( $self, $arg ) = @_;
    my @args = split /\:/, $arg;
    $self->{out} .= qq{<a href="/art$args[0]"$self->{extra}->{links_class}} . ( $args[1] ? qq~ title="$args[1]"~ : '') . '>';
    $self->{in}->{art}++;
    1;
}

=head2 close
=cut

sub close {
    my $self = shift;
    return unless $self->{in}->{art};
    $self->{out} .= '</a>';
    $self->{in}->{art}--;
}

1;