package BBQ::Tags::user;
use common::sense;

=head1 NAME

BBQ::Tags::user

=head1 VERSION

Version 0.01

=head2 open
=cut

sub open {
    my ( $self, $arg ) = @_;

    if ( $arg ) {
        $self->{in}->{user_arg} = $arg;
    }

    $self->{out} .= qq{<a href="/user}; #"
    $self->{in}->{user}++;
    1;
}

=head2 text
=cut

sub text {
    my ( $self, $text ) = @_;

    if ( exists $self->{in}->{user_arg} ) {
        $self->{out} .= delete $self->{in}->{user_arg};
    }
    else {
        $self->{out} .= '/' . lc($text);
    }

    $self->{out} .=  '"' . $self->{extra}->{links_class}. '>' . $text;
}

=head2 close
=cut

sub close {
    my $self = shift;
    return unless $self->{in}->{user};

    $self->{out} .= '</a>';
    $self->{in}->{user}--;
}

1;