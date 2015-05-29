package BBQ::Tags::subtitle;
use common::sense;

sub open {
    my $self = shift;
    $self->{out} .= qq{<div class="t2">};
    $self->{in}->{subtitle}++;
    1;
}

sub close {
    my $self = shift;
    return unless $self->{in}->{subtitle};
    $self->{out} .= '</div>';
    $self->{in}->{subtitle}--;
}

1;