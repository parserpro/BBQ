package BBQ::Tags::spoiler;
use common::sense;

sub open {
    my $self = shift;
    $self->{out} .= q~<div style="margin:5px"><small><b>Спойлер (раскрытие сюжета)</b> <font color="#606060">(кликните по нему, чтобы увидеть)</font></small><br><div class="h" onClick="if(this.style.color=='black'){this.style.color='F9FAFB'}else{this.style.color='black'}">~;
    $self->{in}->{spoiler2}++;
}

sub text {
    my ( $self, $text ) = @_;
    $self->{out} .= $text if $text;
}

sub close {
    my $self = shift;
    return unless $self->{in}->{spoiler2};
    $self->{out} .= '</div></div>';
    $self->{in}->{spoiler2}--;
}

1;
