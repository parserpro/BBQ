package BBQ;
use strict;
use warnings;
use utf8;
use FindBin;
use BBQ::Formats;
use Data::Dumper;

my $imported = 0;
my %all;

my $bbq;
$bbq = {
    'debug'    => 0,         # debug flag
    'in'       => {},        # counter for tags
    'out'      => '',        # putput buffer
    'format'   => 'default', # default format name
    'open'     => {},        #----
    'text'     => {},        # hashes with coderefs for tags handlers
    'close'    => {},        #----
    'set'      => [],        # set of tags to handle
    'on_open'  => \&op,
    'on_close' => \&cl,
    'on_text'  => \&tx,
    'path'     => [],        # current path, similair to XPath
    'leave'    => 1,         # leave unhandled tags as is
    'pda'      => 0,         # mobile version requires different markup
    @_,
};

sub new {
    my $class = shift;
    $class = ref $class || $class;
    default(@_);
    bless $bbq, $class unless ref $bbq eq 'BBQ';
    return $bbq;
}

sub init {
    my ( $class, %args ) = @_;
    $bbq->{enabled} = {};
    for ( grep {exists $args{$_}} qw(debug format set leave pda) ) {
        $bbq->{$_} = $args{$_}
    };

    $bbq->{set} = $BBQ::Formats::formats{$bbq->{'format'}} if ! $bbq->{set} || exists $args{'format'};
    $bbq->{enabled}->{$_}++ for @{$bbq->{set}};
}

sub default {
    my %args = @_;
    init(
        'fake_class',
        debug  => 0,
        ( ! exists $args{set} ? (format => 'default') : () ),
        leave  => 1,
        pda    => 0,
        %args,
    );
}

sub parse {
    my ($class, $content, %args) = @_;

    # чтоб не поломать старый код
    $bbq = $class if ref $class;

    $class->init( %args ) if %args;

    $bbq->{in}  = {};
    $bbq->{out} = '';

    while ( $content =~ /\G(?:.*?)(?:\[([^\]]+)\]|([^\[]+))/gs ) {
        my ($tag, $text) = ($1, $2);

        if ( $tag ) {
            $tag = lc $tag;

            if ( index($tag, '/') == 0 && ref $bbq->{on_close} ) {
                $tag = substr($tag, 1);

                $bbq->{on_close}->($tag);
                next;
            }

            my $t = index($tag, '=');
            my $arg;
            ( $tag, $arg ) = ( substr($tag, 0, $t), substr($tag, ++$t) ) if $t > -1;

            $bbq->{on_open}->($tag, $arg) if ref $bbq->{on_open}
        }
        else {
            $bbq->{on_text}->($text) if ref $bbq->{on_text}
        }
    }

    return $bbq->{out};
}

sub op {
    my ($tag, $arg ) = @_;

    if ( exists $bbq->{'enabled'}->{$tag} && exists $bbq->{'open'}->{$tag} ) {
        push @{$bbq->{path}}, $tag;
        $bbq->{'open'}->{$tag}->($bbq, $arg);

        # закрывающего тэга нет - убираем за собой
        pop @{$bbq->{path}} unless exists $bbq->{'close'}->{$tag};
    }
    elsif ( $bbq->{leave} ) {
        $bbq->{out} .= '[' . $tag . ( $arg ? '=' . $arg : '' ) . ']';
    }
}

sub cl {
    my ($tag) = @_;

    if ( exists $bbq->{'enabled'}->{$tag} && exists $bbq->{'close'}->{$tag} ) {
        $bbq->{'close'}->{$tag}->($bbq);
        pop @{$bbq->{path}};
    }
    elsif ( $bbq->{leave} ) {
        $bbq->{out} .= '[/' . $tag . ']';
    }
}

sub tx {
    my ($text) = @_;
    my $tag = $bbq->{path}->[-1];

    if ( $tag && exists $bbq->{'enabled'}->{$tag} && exists $bbq->{'text'}->{$tag} ) {
        $bbq->{'text'}->{$tag}->($bbq, @_);
    }
    else {
        $bbq->{out} .= $text;
    }
}

sub import {
    return if $imported;

    my $dir = $INC{'BBQ.pm'};
    $dir =~ s/\/BBQ\.pm$//;
    my @files = glob("$dir/BBQ/Tags/*.pm");

    for my $file ( @files ) {
        $file =~ s/^.+?\/([^\/]+)\.pm$/$1/;
        my $mod = "BBQ::Tags::$file";
        eval "use $mod;";
        warn $@ if $@;

        {
            no strict;
            no warnings 'once';

            if ( ${ $mod . '::tag'} ) {
                $file = ${ $mod . '::tag'};
            }
        }

        $all{$file} = {
            'open'  => \&{$mod . '::open'},
            'close' => \&{$mod . '::close'},
            (
                $mod->can('text') ?
                    ( 'text'  =>  \&{$mod . '::text'} ) : (),
            ),
        };
    }

    for my $tag ( keys %all ) {
        for my $action ( qw(open text close) ) {
            $bbq->{$action}->{$tag} = $all{$tag}->{$action} if $all{$tag}->{$action};
        }
    }

    bless $bbq, __PACKAGE__;
    default();
    $imported++;
}

#==============================================================
# TODO: сделать (link)
#$message =~ s/\[user\](.+?)\[\/user\]/"<a$class href=\"\/user" . BD::User->get_user_id_by_login($1) . "\">$1<\/a>"/ieg;

# TODO: сделать (format)
# $message =~ s/\[br\]/\<br\>/ig;
# $message =~ s/\[gray\](.+?)\[\/gray\]/<font color=gray>$1<\/font>/igs;

# TODO: цитаты
#    elsif ($tag eq 'q') {
# TODO: сообщение модератора
#    elsif ($tag eq 'moder') {
# TODO: код
#    elsif ($tag eq 'code') {

# # аудио
# $message =~ s/\[AUDIO=(.+?)prostopleer.com\/tracks\/(.+?)\]/\n<object width='411' height='28'><param name='movie' value='http:\/\/embed.prostopleer.com\/track?id=$2'><\/param><embed src='http:\/\/embed.prostopleer.com\/track?id=$2' type='application\/x-shockwave-flash' width='411' height='28'><\/embed><\/object>\n/ig;
# $message =~ s/\[AUDIO=(.+?)prostopleer.com\/(\#\/|)list(.+?)\]/\n<object width='419' height='115'><param name='movie' value='http:\/\/embed.prostopleer.com\/list?id=$3'><\/param><embed src='http:\/\/embed.prostopleer.com\/list?id=$3' type='application\/x-shockwave-flash' width='419' height='115'><\/embed><\/object>\n/ig;

1;