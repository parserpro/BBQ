package BBQ::Tags::code;
use common::sense;

=head1 NAME

BBQ::Tags::code

=head1 VERSION

Version 0.01

=head2 open
=cut

sub open {
    my ( $self, $name ) = @_;
    $self->off;
    $self->{out} .= qq{<fieldset class="quote pre"><legend>$name</legend>};
    $self->{in}->{code}++;
    1;
}

=head2 text
=cut

sub text {
    my ( $self, $text ) = @_;
    $text =~ s/\[/&#091;/ig;
    $text =~ s/\]/&#093;/ig;
    $text =~ s/\</&lt;/ig;
    $text =~ s/\>/&gt;/ig;
    $text =~ s/\t/        /ig;
    $self->{out} .= $text;
}

=head2 close
=cut

sub close {
    my $self = shift;
    return unless $self->{in}->{code};
    $self->{out} .= '</fieldset>';
    $self->{in}->{code}--;
    $self->on;
}

1;