package BBQ::Tags::q;
use common::sense;

our @alias = qw(quote);
=head1 NAME

BBQ::Tags::q

=head1 VERSION

Version 0.01

=head2 open
=cut

sub open {
    my ($self, $arg) = @_;
    return 0 if $arg =~ /[\"<>]/;

    $self->{out} .= qq~<blockquote class="quote"><p>цитата <cite>$arg</cite></p><div>~;
    $self->{in}->{q}++;
    1;
}

=head2 close
=cut

sub close {
    my $self = shift;
    return unless $self->{in}->{q};
    $self->{out} .= '</div></blockquote>';
    $self->{in}->{q}--;
}

1;
