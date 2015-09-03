package BBQ::Tags::h;
use common::sense;

=head1 NAME

BBQ::Tags::h

=head1 VERSION

Version 0.01

=head2 open
=cut

sub open {
    my $self = shift;
    $self->{out} .= '<div class="hidden-spoiler"><p>скрытый текст <span>(кликните по нему, чтобы увидеть)</span></p><div>';
    $self->{in}->{spoiler1}++;
    1;
}

=head2 close
=cut

sub close {
    my $self = shift;
    return unless $self->{in}->{spoiler1};
    $self->{out} .= '</div></div>';
    $self->{in}->{spoiler1}--;
}

1;