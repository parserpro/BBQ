package BBQ::Tags::compl;
use common::sense;

=head1 NAME

BBQ::Tags::compl

=head1 VERSION

Version 0.01

=head2 open
=cut

sub open {
    my ( $self, $arg ) = @_;
    my @args = split /\:/, $arg;
    $self->{out} .= qq{<a href="/autor$args[0]"$self->{extra}->{links_class}} . ( $args[1] ? qq~ title="$args[1]"~ : '') . '>'; #'
    $self->{in}->{compl}++;
    1;
}

=head2 close
=cut

sub close {
    my $self = shift;
    return unless $self->{in}->{compl};
    $self->{out} .= '</a>';
    $self->{in}->{compl}--;
}

1;