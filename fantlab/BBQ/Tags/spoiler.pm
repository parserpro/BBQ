package BBQ::Tags::spoiler;
use common::sense;

sub open {
    my $self = shift;
    $self->{out} .= '<div class="hidden-spoiler"><p>Спойлер (раскрытие сюжета) <span>(кликните по нему, чтобы увидеть)</span></p><div>';
    $self->{in}->{spoiler2}++;
}

sub close {
    my $self = shift;
    return unless $self->{in}->{spoiler2};
    $self->{out} .= '</div></div>';
    $self->{in}->{spoiler2}--;
}

1;
