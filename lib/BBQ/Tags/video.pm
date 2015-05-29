package BBQ::Tags::video;
use common::sense;

my ($x, $y);

my %video_whitelist = (
    'youtube' => [
        {
            're'   => qr/^.*youtube\.com\/watch\?v=(.+?)(?:\&.*)?$/i,
            'code' => sub {
                my (@args) = @_;

                return qq~
<iframe width="$x" height="$y" src="//www.youtube.com/embed/$args[0]?rel=0" frameborder="0" allowfullscreen></iframe>
~;
            },
        },
    ],
);

sub process_video {
    my ($self, $arg) = @_;
MAIN:
    while ( my ($key, $val) = each %video_whitelist ) {
        for my $link ( @$val ) {
            if ( my @list = $arg =~ $link->{re} ) {
                $self->{out} .= $link->{code}->(@list);

                # resetting the "each" internal iterator
                keys %video_whitelist;
                last MAIN;
            }
        }
    }
}

sub open {
    my ( $self, $arg ) = @_;

    if ( $self->{pda} ) {
        ($x, $y) = ( 300, 180 );
    }
    else {
        ($x, $y) = ( 640, 385 );
    }

    process_video($self, $arg);

    if ( $arg ) {
        # закрывающего тэга нет, но определение есть - автоприборка не сработает
        pop @{$self->{path}};
    }
    else {
        $self->{in}->{video}++;
    }

    1;
}

sub close {
    my $self = shift;
    return unless $self->{in}->{video};

    $self->{in}->{video}--;
}

sub text {
    my ( $self, $arg ) = @_;

    process_video($self, $arg);
}

1;