package BBQ::Tags::link;
use common::sense;

sub open {
    my ( $self, $arg ) = @_;
    $arg = substr($arg, 1) if index($arg, '/') == 0;
    $self->{out} .= qq{<a href="/$arg"$self->{extra}->{links_class}>};
    $self->{in}->{link}++;
    1;
}

sub close {
    my $self = shift;
    return unless $self->{in}->{link};
    $self->{out} .= '</a>';
    $self->{in}->{link}--;
}

1;