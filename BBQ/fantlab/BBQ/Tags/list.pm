package BBQ::Tags::list;
use common::sense;

sub open {
    my $self = shift;
    $self->{out} .= '<ul>';
    $self->{in}->{ul}++;
}

sub close {
    my $self = shift;

    if ( $self->{in}->{li}->{ $self->{in}->{ul} } ) {
        $self->{out} .= '</li>';
        $self->{in}->{li}->{ $self->{in}->{ul} }--;
    }

    $self->{out} .= '</ul>';
    $self->{in}->{ul}--;
}

1;