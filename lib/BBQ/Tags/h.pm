package BBQ::Tags::h;
use common::sense;

sub open {
    my $self = shift;
    $self->{out} .= '<div class="hidden-spoiler"><p>скрытый текст <span>(кликните по нему, чтобы увидеть)</span></p><div>';
    $self->{in}->{spoiler1}++;
    1;
}

sub close {
    my $self = shift;
    return unless $self->{in}->{spoiler1};
    $self->{out} .= '</div></div>';
    $self->{in}->{spoiler1}--;
}

1;