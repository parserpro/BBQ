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
    warn "=== running code::open" if $self->{debug};
    $self->off;
    $self->{out} .= qq{<fieldset class="quote pre"><legend>$name</legend>};
    $self->{in}->{code}++;
    1;
}

=head2 text
=cut

sub text {
    my ( $self, $text ) = @_;
    warn "=== running code::text [$text]\n" if $self->{debug};
    $text =~ s/\[/&#091;/ig;
    $text =~ s/\]/&#093;/ig;
    $text =~ s/\</&lt;/ig;
    $text =~ s/\>/&gt;/ig;
    $text =~ s/\t/        /ig;
    warn "=== code::text out [$text]\n" if $self->{debug};
    $self->{out} .= $text;
}

=head2 close
=cut

sub close {
    my $self = shift;
    warn "=== running code::close" if $self->{debug};
    return unless $self->{in}->{code};
    $self->{out} .= '</fieldset>';
    $self->{in}->{code}--;
    $self->on;
    1;
}

1;