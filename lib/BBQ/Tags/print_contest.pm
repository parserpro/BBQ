package BBQ::Tags::print_contest;
use common::sense;

sub open {
    my ( $self, $contest_id ) = @_;

    my $contest_info = BD::Award->get_contest_works($contest_id, 0);
    $self->{out} .= $Fantlab::mojo->contest_item($contest_info, 3);
    1;
}

1;