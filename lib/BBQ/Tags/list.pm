package BBQ::Tags::list;
use common::sense;

=head1 NAME

BBQ::Tags::list

=head1 VERSION

Version 0.01

=head2 open
=cut

my %lists = (
    1 => 'decimal',
    I => 'upper-roman',
    A => 'upper-alpha',
    i => 'lower-roman',
    a => 'lower-alpha',
    o => 'circle',
    O => 'disc',
    n => 'none',
);

sub open {
    my ( $self, $style ) = @_;
    $style = 'O' unless $style;
    return unless $lists{$style};

    $self->{out} .= '<ol style="list-style-type: ' . $lists{$style} . ';">';
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

    $self->{out} .= '</ol>';
    $self->{in}->{ul}--;
}

1;