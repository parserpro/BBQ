package BBQ::Tags::subtitle;
use common::sense;

=head1 NAME

BBQ::Tags::subtitle

=head1 VERSION

Version 0.01

=head2 open
=cut

sub open {
    my $self = shift;
    $self->{out} .= qq{<div class="t2">};
    $self->{in}->{subtitle}++;
    1;
}

=head2 close
=cut

sub close {
    my $self = shift;
    return unless $self->{in}->{subtitle};
    $self->{out} .= '</div>';
    $self->{in}->{subtitle}--;
}

1;