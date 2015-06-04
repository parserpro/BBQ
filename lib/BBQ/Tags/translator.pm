package BBQ::Tags::translator;
use common::sense;

sub open {
    my ( $self, $arg ) = @_;
    $self->{out} .= qq{<a href="/translator$arg"$self->{extra}->{links_class}>};
    $self->{in}->{translator}++;
    1;
}

sub close {
    my $self = shift;
    return unless $self->{in}->{translator};
    $self->{out} .= '</a>';
    $self->{in}->{translator}--;
}

1;