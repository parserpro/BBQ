package BBQ::Tags::list;
use common::sense;

=head1 NAME

BBQ::Tags::list

=head1 VERSION

Version 0.01

=head2 open
=cut

sub open {
    my $self = shift;
    $self->{out} .= '<ul>';
    $self->{in}->{ul}++;
    1;
}

=head2 close
=cut

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