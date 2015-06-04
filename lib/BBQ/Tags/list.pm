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

my @def = qw(o O);

sub open {
    my ( $self, $style ) = @_;
    $self->{in}->{ul}++;
    $style = $def[$self->{in}->{ul} % 2] unless $style;
    $style = 'O' unless $style;
    return unless $lists{$style};

    $self->{out} .= '<ol style="list-style-type: ' . $lists{$style} . ';">';

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