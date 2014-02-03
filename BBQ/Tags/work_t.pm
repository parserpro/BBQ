package BBQ::Tags::work_t;
use common::sense;
use Data::Dumper;

sub open {
    my ($self, $arg) = @_;

    return unless $arg =~ /^(\d+)(?>\:([0-9\,]+))?(?>\:([-A-zА-я\ ёі]+))?(?>\;art=([0-9\,]+))?$/;

    my $work_id        = $1;
    my $translators    = $2;
    my $work_type_free = $3;
    my $arts           = $4;

    warn "\$work_id=$work_id, \$translators=$translators, \$work_type_free=$work_type_free, \$arts=$arts\n" if $self->{debug};

    my $work_type = $work_type_free ? $work_type_free : lc(BD::Work->get_work_type_by_work($work_id));

    warn "\$work_type=$work_type\n" if $self->{debug};

    $self->{in}->{work_t_data} = [];
    push @{$self->{in}->{work_t_data}}, $work_type if $work_type;

    # если есть переводчики
    if ( $translators ) {
        push @{$self->{in}->{work_t_data}}, 'перевод ' .
            # всё соединяем
            join(
                ', ',
                # получаем куски строки из id-шников
                map {
                    "<a href=\"/translator$_\">" .
                    BD::Person->get_person_name_rp('translator', $_) .
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
                    "<a href=\"/art$_\">" . BD::Person->get_person_name_rp('art', $_) . '</a>'
                }
                grep { $_ }
                split ',', $arts
            );
    }

    $self->{in}->{work_t_data} = '(' . join(', ', @{$self->{in}->{work_t_data}}) . ')' if $self->{in}->{work_t_data};
    $self->{out} .= qq{<a href="/work$work_id">};
    $self->{in}->{work_t}++;
}

1;