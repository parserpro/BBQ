package BBQ::Tags::_asteriks;
use common::sense;

our $tag = '*';

=head1 NAME

BBQ::Tags::_asteriks

=head1 VERSION

Version 0.01

=head2 open
=cut

sub open {
    my $self = shift;

    if ( $self->{in}->{li}->{ $self->{in}->{ul} } ) {
        $self->{out} .= '</li>';
        $self->{in}->{li}->{ $self->{in}->{ul} }--;
    }

    $self->{out} .= '<li>';
    $self->{in}->{li}->{ $self->{in}->{ul} }++;
    1;
}

=head2 text
=cut

sub text {
    my ($self, $text) = @_;
    $text =~ s/\n//g;
}

1;