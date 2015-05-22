package BBQ::Tags::size;
use common::sense;

=head1 NAME

BBQ::Tags::size

=head1 VERSION

Version 0.01

=head2 open
=cut

sub open {
    my ($self, $size) = @_;
    return 0 unless $size =~ /^\d+$/ && $size > 0 && $size < 201;
    $self->{out} .= qq~<span style="font-size:$size%;">~;
    $self->{in}->{size}++;
    1;
}

=head2 close
=cut

sub close {
    my $self = shift;
    return unless $self->{in}->{size};
    $self->{out} .= '</span>';
    $self->{in}->{size}--;
}

1;
