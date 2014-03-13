package BBQ::Tags::dictor;
use common::sense;

sub open {
    my ( $self, $arg ) = @_;
    my @args = split /\:/, $arg;
    $self->{out} .= qq{<a href="/dictor$args[0]"} . ( $args[1] ? qq~ title="$args[1]"~ : '') . '>'; #'
    $self->{in}->{dictor}++;
}

sub close {
    my $self = shift;
    return unless $self->{in}->{dictor};
    $self->{out} .= '</a>';
    $self->{in}->{dictor}--;
}

1;