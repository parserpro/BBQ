package BBQ::Tags::right;
use common::sense;

sub open {
    my $self = shift;
    $self->{out} .= '<p style="text-align: right">';
    $self->{in}->{right}++;
}

sub close{
    my $self = shift;
    return unless $self->{in}->{right};
    $self->{out} .= '</p>';
    $self->{in}->{right}--;
}

1;