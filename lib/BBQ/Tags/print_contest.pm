package BBQ::Tags::print_contest;
use common::sense;

=head1 NAME

BBQ::Tags::print_contest

=head1 VERSION

Version 0.01

=head2 open
=cut

sub open {
    my ( $self, $contest_id ) = @_;

    my $contest_info = BD::Award->get_contest_works($contest_id, 0);
    $self->{out} .= $Fantlab::mojo->contest_item($contest_info, 3);
    1;
}

1;