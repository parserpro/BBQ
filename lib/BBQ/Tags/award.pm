package BBQ::Tags::award;
use common::sense;

sub open {
    my ( $self, $arg ) = @_;
    $self->{out} .= qq{<a href="/award$arg"$self->{extra}->{links_class}>};
    $self->{in}->{award}++;
    1;
}

sub close {
    my $self = shift;
    return unless $self->{in}->{award};
    $self->{out} .= '</a>';
    $self->{in}->{award}--;
}

1;