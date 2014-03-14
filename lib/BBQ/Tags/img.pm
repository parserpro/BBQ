package BBQ::Tags::img;
use common::sense;

=head1 NAME

BBQ::Tags::img

=head1 VERSION

Version 0.01

=head2 open
=cut

sub open {
    my ($self, $href) = @_;
    return 0 if $href =~ /[>\"]/;

    if ( $href ) {
        $self->{out} .= '<img src="' . $href . '" alt="" />';
        return 1;
    }

    $self->{in}->{img}++;
    1;
}

=head2 text
=cut

sub text {
    my ( $self, $text ) = @_;

    $self->{out} .= '<img src="' . $text . '" alt="" />';
}

=head2 close
=cut

sub close {
    my $self = shift;
    $self->{in}->{img}-- if $self->{in}->{img};
}

1;