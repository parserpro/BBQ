package BBQ::Tags::list;
use common::sense;

=head1 NAME

BBQ::Tags::list

=head1 VERSION

Version 0.01

=head2 open
=cut

my @stack;
my %lists = (
  1 => '<ol style="list-style-type: decimal;">',
  I => '<ol style="list-style-type: upper-roman;">',
  A => '<ol style="list-style-type: upper-alpha;">',
  i => '<ol style="list-style-type: lower-roman;">',
  a => '<ol style="list-style-type: lower-alpha;">',
  o => '<ol style="list-style-type: circle;">',
  O => '<ol style="list-style-type: disc;">',
  n => '<ol style="list-style-type: none;">',
);

sub open {
    my ( $self, $style ) = @_;
    $style = 'O' unless $style;
    return unless $lists{$style};

    $self->{out} .= $lists{$style};
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