package BBQ::Tags::user;
use common::sense;

sub open {
    my ( $self, $arg ) = @_;

    if ( $arg ) {
        $self->{in}->{user_arg} = $arg;
    }

    $self->{out} .= qq{<a href="/user}; #"
    $self->{in}->{user}++;
}

sub text {
    my ( $self, $text ) = @_;

    if ( $self->{in}->{user_arg} ) {
        $self->{out} .= delete $self->{in}->{user_arg};
    }
    else {
        $self->{out} .= '/' . lc($text);
    }

    $self->{out} .=  '">' . $text;
}

sub close {
    my $self = shift;
    return unless $self->{in}->{user};

    $self->{out} .= '</a>';
    $self->{in}->{user}--;
}

1;