package BBQ::Tags::article;
use common::sense;

sub open {
    my ( $self, $arg ) = @_;
    $self->{out} .= qq{<a href="/article$arg"$self->{extra}->{links_class}>};
    $self->{in}->{article}++;
    1;
}

sub close {
    my $self = shift;
    return unless $self->{in}->{article};
    $self->{out} .= '</a>';
    $self->{in}->{article}--;
}

1;