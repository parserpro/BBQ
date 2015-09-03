package BBQ::Tags::work;
use common::sense;
use utf8;

=head1 NAME

BBQ::Tags::work

=head1 VERSION

Version 0.01

=head2 open
=cut

sub open {
    my ($self, $arg) = @_;
    return unless $arg =~ /^(\d+)(?>\:([0-9\,]+))?(?>\:([-A-zА-я\ ёі]+))?(?>\;art=([0-9\,]+))?$/;

    my $work_id        = $1;
    my $translators    = $2;
    my $work_type_free = $3;
    my $arts           = $4;

    # если есть переводчики
    if ( $translators ) {
        push @{$self->{in}->{work_t_data}}, 'перевод ' .
            # всё соединяем
            join(
                ', ',
                # получаем куски строки из id-шников
                map {
                    "<a class=\"agray\" href=\"/translator$_\">" .
                    BD::Person->get_person_name_rp($_, 'translator') .
                    '</a>'
                }
                # выкидываем мусор
                grep { $_}
                # бьём строку по запятым
                split /,/, $translators
            );
    }

    # художники
    if ( $arts ) {
        push @{$self->{in}->{work_t_data}}, 'иллюстрации ' .
            join(
                ', ',
                map {
                    "<a class=\"agray\" href=\"/art$_\">" . BD::Person->get_person_name_rp($_, 'art') . '</a>'
                }
                grep { $_ }
                split ',', $arts
            );
    }

    $self->{in}->{work_t_data} = ' (' . join(', ', @{$self->{in}->{work_t_data}}) . ')' if $self->{in}->{work_t_data};
    my $popup_hint = (Profile->disable_popup_hint ? '' : qq{ class="fantlab work_$work_id" data-fantlab_type="work" data-fantlab_id="$work_id"});
    $self->{out} .= qq{<span$popup_hint><a href="/work$work_id"$self->{extra}->{links_class}>};
    $self->{in}->{work}++;
    1;
}

=head2 close
=cut

sub close {
    my $self = shift;

    if ( $self->{in}->{work_t} ) {
        $self->{out} .= '</a>' . (delete $self->{in}->{work_t_data}) . '</span>';
        $self->{in}->{work_t}--;
    }
    elsif ( $self->{in}->{work} ) {
        $self->{out} .= '</a>' . (delete $self->{in}->{work_t_data}) . '</span>';
        $self->{in}->{work}--;
    }
}

1;
