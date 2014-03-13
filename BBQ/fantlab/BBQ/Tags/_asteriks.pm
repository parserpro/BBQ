package BBQ::Tags::_asteriks;
use common::sense;

our $tag = '*';

sub open {
    my $self = shift;

    if ( $self->{in}->{li}->{ $self->{in}->{ul} } ) {
        $self->{out} .= '</li>';
        $self->{in}->{li}->{ $self->{in}->{ul} }--;
    }

    $self->{out} .= '<li>';
    $self->{in}->{li}->{ $self->{in}->{ul} }++;
}

1;