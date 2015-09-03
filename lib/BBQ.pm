package BBQ;

use 5.010;
use strict;
#use warnings FATAL => 'all';
use utf8;
use FindBin;
use BBQ::Formats;
use Carp;
use Data::Dumper;

=head1 NAME

BBQ - fastest pure Perl BBCode parser

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


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
    'off'      => 0,         # ignore tags at all
    'current'  => '',        # current tag, set in op
    'extra'    => {},        # extra custom parameters for handlers
    'prev_hdl' => undef,     # previous handler, for correct [ handling
    @_,
};


=head1 SYNOPSIS

Processing BBCodes as fast as possible.

    use BBQ;

    my $bbq = BBQ->new();
    ...

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 SUBROUTINES/METHODS

=head2 new

=cut

sub new {
    my $class = shift;
    $class = ref $class || $class;
    &default(@_);
    bless $bbq, $class unless ref $bbq eq 'BBQ';
    return $bbq;
}

=head2 init

=cut

sub init {
    my ( $class, %args ) = @_;
    $bbq->{enabled} = {};

    for ( grep {exists $args{$_}} qw(debug format set leave pda path in out off extra) ) {
        $bbq->{$_} = $args{$_}
    };

    $bbq->{set} = $BBQ::Formats::formats{$bbq->{'format'}} if ! $bbq->{set} || exists $args{'format'};
    $bbq->{enabled}->{$_}++ for @{$bbq->{set}};
    return;
}

=head2 parse

=cut

sub parse {
    my ($class, $content, %args) = @_;

    warn "content: $content" if $bbq->{debug};

    # чтоб не поломать старый код
    $bbq = $class if ref $class;

    $class->init( %args ) if %args;

    $bbq->{in}   = {};
    $bbq->{out}  = '';
    $bbq->{path} = [];

    warn "content: $content" if $bbq->{debug};

    while ( $content =~ /\G        # store position
                           (?:.*?) # for string beginning
                           (?:     # do not capture
                             \[    # tag start
                                (  # capture 1, for tag
                                  [^\[]*? # not an opening [, not greedy, may be empty
                                )  # capture 1 end
                             \]    # tag end
                           |
                             (       # capture 2, tor text
                               .+?   # text, may be empty
                               (?=\[|$)  # positive lookahead for tag start
                             ) # capture 2 end
                           )/igsxo ) {
        my ($tag, $text) = ($1, $2);
        $text = $3 if defined $3;
        warn "capture ~$1~ ~$2~ ~$3~\n" if $bbq->{debug};
        warn "off: $bbq->{off} " . ( $tag ? "tag: $tag" : '' ) . ( $text ? "text: $text" : '') . "\n" if $bbq->{debug};

        if ( $bbq->{off} && $tag && $bbq->{current} ne $tag ) {
            $text = '[' . $tag . ']';
            $tag  = undef;
        }

        if ( $tag ) {
            my $t = index($tag, '=');
            my $arg;
            ( $tag, $arg ) = ( substr($tag, 0, $t), substr($tag, ++$t) ) if $t > -1;

            if ( index($tag, '/') == 0 && ref $bbq->{on_close} eq 'CODE' ) {
                $tag = substr($tag, 1);

                $bbq->{on_close}->($tag);
                next;
            }

            if ( exists $bbq->{'open'}->{lc $tag} ) {
                $bbq->{on_open}->($tag, $arg) if ref $bbq->{on_open} eq 'CODE';
            }
            else {
                $bbq->{on_text}->('[' . $tag . ']') if ref $bbq->{on_text} eq 'CODE';
            }
        }
        else {
            $bbq->{on_text}->($text) if ref $bbq->{on_text} eq 'CODE';
        }
    }

    for my $tag ( reverse @{$bbq->{path}} ) {
        $bbq->{on_close}->($tag);
    }

    return $bbq->{out};
}

=head2 off

=cut

sub off {
    $bbq->{off} = 1;
    return;
}

=head2 on

=cut

sub on {
    $bbq->{off} = 0;
    return;
}

=head2 default

=cut

sub default {
    shift @_ if ref $_[0] eq 'BBQ';
    my %args = @_;
    init(
        'fake_class',
        debug    => 0,
        ( ! exists $args{set} ? (format => 'default') : () ),
        leave    => 1,
        pda      => 0,
        path     => [],
        in       => {},
        out      => '',
        off      => 0,
        extra    => {},
        %args,
    );
    return;
}

=head1 AUTHOR

Demiurg, C<< <parserpro at gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-bbq at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=BBQ>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc BBQ


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=BBQ>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/BBQ>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/BBQ>

=item * Search CPAN

L<http://search.cpan.org/dist/BBQ/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2014 Demiurg.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

Any use, modification, and distribution of the Standard or Modified
Versions is governed by this Artistic License. By using, modifying or
distributing the Package, you accept this license. Do not use, modify,
or distribute the Package, if you do not accept this license.

If your Modified Version has been derived from a Modified Version made
by someone other than you, you are nevertheless required to ensure that
your Modified Version complies with the requirements of this license.

This license does not grant you the right to use any trademark, service
mark, tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge
patent license to make, have made, use, offer to sell, sell, import and
otherwise transfer the Package with respect to any patent claims
licensable by the Copyright Holder that are necessarily infringed by the
Package. If you institute patent litigation (including a cross-claim or
counterclaim) against any party alleging that the Package constitutes
direct or contributory patent infringement, then this Artistic License
to you shall terminate on the date that such litigation is filed.

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER
AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


=cut


=head2 op
=cut

sub op {
    my ($tag, $arg ) = @_;
    warn "op: [$tag], [$arg]\n" if $bbq->{debug};

    my $tag_lc = lc $tag;

    # если тэг разрешен и у него есть обработчик открытия тэга
    if ( exists $bbq->{'enabled'}->{$tag_lc} && exists $bbq->{'open'}->{$tag_lc} ) {
        $bbq->{current} = '/' . $tag_lc;

        # добавляем тэг к текущему пути
        push @{$bbq->{path}}, $tag_lc;

        # если обработчик открытия тэга не вернул TRUE
        unless ( $bbq->{'open'}->{$tag_lc}->($bbq, $arg) ) {
            # убираем тэг от текущего пути
            pop @{$bbq->{path}};

            # выдаем исходник тэга если есть соотв. настройка
            $bbq->{out} .= '[' . $tag . ( $arg ? '=' . $arg : '' ) . ']' if $bbq->{leave};
            return;
        };

        # tag shouldn't be closed - wipe it out
        pop @{$bbq->{path}} unless exists $bbq->{'close'}->{$tag_lc};
    }
    elsif ( $bbq->{leave} ) {
        $bbq->{out} .= '[' . $tag . ( $arg ? '=' . $arg : '' ) . ']';
    }

    return;
}

=head2 cl
=cut

sub cl {
    my ($tag) = @_;
    warn "cl: [$tag]\n" if $bbq->{debug};

    my $tag_lc = lc $tag;

    # если тэг разрешен, для него есть обработчик закрытия и есть что закрывать
    if ( exists $bbq->{'enabled'}->{$tag_lc} && exists $bbq->{'close'}->{$tag_lc} && @{$bbq->{path}} ) {
        if ( $bbq->{path}->[-1] ne 'work_t' ) {
            # at first, we should close previouse opened tag
            while ( @{$bbq->{path}} && $bbq->{path}->[-1] ne $tag_lc ) {
                $bbq->{on_close}->($bbq->{path}->[-1]);
            }
        }

        # no open tag - exit
        unless ( @{$bbq->{path}} ) {
            $bbq->{out} .= '[/' . $tag . ']' if $bbq->{leave};
            return;
        }

        $bbq->{'close'}->{$tag_lc}->($bbq);
        pop @{$bbq->{path}} if $bbq->{path};
    }
    elsif ( $bbq->{leave} ) {
        $bbq->{out} .= '[/' . $tag . ']';
    }

    return;
}

=head2 tx
=cut

sub tx {
    my ($text) = @_;
    my $tag = $bbq->{path}->[-1];

    warn "tx: [$tag], [$text]\n" if $bbq->{debug};


    if ( $tag && exists $bbq->{'enabled'}->{$tag} && exists $bbq->{'text'}->{$tag} && $bbq->{in}->{$tag} ) {
        $bbq->{'text'}->{$tag}->($bbq, @_);
    }
    else {
        $bbq->{out} .= $text;
    }

    return;
}

sub import {
    return if $imported;

    my $dir = $INC{'BBQ.pm'};
    $dir =~ s/\/BBQ\.pm$//;
    my @files = glob("$dir/BBQ/Tags/*.pm");

    for my $file ( @files ) {
        $file =~ s/^.+?\/([^\/]+)\.pm$/$1/;
        my $mod = "BBQ::Tags::$file";
        $mod =~ /^(.+)$/;
        eval "use $1;";
        warn $@ if $@;

        {
            no strict 'refs';
            no warnings 'once';

            if ( ${ $mod . '::tag'} ) {
                $file = ${ $mod . '::tag'};
            }

            for my $tag ( $file, @{ $mod . '::alias' ? $mod . '::alias' : [] } ) {
                $all{$tag} = {
                    'open'  => \&{$mod . '::open'},
                    (
                        $mod->can('close') ?
                            ( 'close' => \&{$mod . '::close'} ) : (),
                    ),
                    (
                        $mod->can('text') ?
                            ( 'text'  =>  \&{$mod . '::text'} ) : (),
                    ),
                };
            }
        }
    }

    for my $tag ( keys %all ) {
        for my $action ( qw(open text close) ) {
            $bbq->{$action}->{$tag} = $all{$tag}->{$action} if $all{$tag}->{$action};
        }
    }

    bless $bbq, __PACKAGE__;
    $imported++;

    return;
}


1; # End of BBQ
