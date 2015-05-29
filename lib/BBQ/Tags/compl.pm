package BBQ::Tags::compl;
use common::sense;

sub open {
    my ( $self, $arg ) = @_;
    my @args = split /\:/, $arg;
    $self->{out} .= qq{<a href="/autor$args[0]"} . ( $args[1] ? qq~ title="$args[1]"~ : '') . '>'; #'
    $self->{in}->{compl}++;
    1;
}

sub close {
    my $self = shift;
    return unless $self->{in}->{compl};
    $self->{out} .= '</a>';
    $self->{in}->{compl}--;
}

1;