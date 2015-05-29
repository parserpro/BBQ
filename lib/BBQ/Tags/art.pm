package BBQ::Tags::art;
use common::sense;

sub open {
    my ( $self, $arg ) = @_;
    my @args = split /\:/, $arg;
    $self->{out} .= qq{<a href="/art$args[0]"} . ( $args[1] ? qq~ title="$args[1]"~ : '') . '>';
    $self->{in}->{art}++;
    1;
}

sub close {
    my $self = shift;
    return unless $self->{in}->{art};
    $self->{out} .= '</a>';
    $self->{in}->{art}--;
}

1;