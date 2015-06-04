package BBQ::Tags::autor;
use common::sense;

sub open {
    my ( $self, $arg ) = @_;
    $self->{out} .= qq{<a href="/autor$arg"$self->{extra}->{links_class}>};
    $self->{in}->{autor}++;
    1;
}

sub close {
    my $self = shift;
    return unless $self->{in}->{autor};
    $self->{out} .= '</a>';
    $self->{in}->{autor}--;
}

1;
