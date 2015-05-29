package BBQ::Tags::hr;
use common::sense;

sub open {
    my $self = shift;

    $self->{out} .= "<br clear=all><hr size=1 width=80% color=gray><br>";
    1;
}

1;