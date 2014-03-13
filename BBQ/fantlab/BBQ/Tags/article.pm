package BBQ::Tags::article;
use common::sense;

sub open {
    my ( $self, $arg ) = @_;
    $self->{out} .= qq{<a href="/article$arg">};
    $self->{in}->{article}++;
}

sub close {
    my $self = shift;
    return unless $self->{in}->{article};
    $self->{out} .= '</a>';
    $self->{in}->{article}--;
}

1;