package BBQ::Tags::hr;
use common::sense;

=head1 NAME

BBQ::Tags::_asteriks

=head1 VERSION

Version 0.01

=head2 open
=cut

sub open {
    my $self = shift;

    $self->{out} .= '<br clear="all"><hr size="1" width="80%" color="gray"><br>';
    return 1;
}

1;