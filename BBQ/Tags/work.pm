package BBQ::Tags::work;
use common::sense;

sub open {
    my ($self, $arg) = @_;
    return unless $arg =~ /^(\d+)(?>\:([0-9\,]+))?(?>\:([-A-zА-я\ ёі]+))?(?>\;art=([0-9\,]+))?$/;

    my $work_id        = $1;
    my $translators    = $2;
    my $work_type_free = $3;
    my $arts           = $4;

    my $data = ( $translators
                  ? 'перевод ' .
                    join(
                        ', ',
                        map {
                            "<a href=\"/translator$_\">" .
                            BD::Person->get_person_name_rp('translator', $_) .
                            '</a>'
                        }
                        grep { $_}
                        split /,/, $translators
                    ) .
                    ', '
                  : '' ) .
               ( $arts
                  ? 'иллюстрации ' .
                    join(
                        ', ',
                        map {
                            "<a href=\"/art$_\">" . BD::Person->get_person_name_rp('art', $_) . '</a>'
                        }
                        grep { $_ }
                        split ',', $arts
                    )
                  : ''
               );

    $self->{in}->{work_t_data} = $data ? " ($data)" : '';
    $self->{out} .= qq{<a href="/work$work_id">};
    $self->{in}->{work}++;
}

sub close {
    my $self = shift;

    if ( $self->{in}->{work_t} ) {
        $self->{out} .= '</a> ';
        $self->{out} .= delete $self->{in}->{work_t_data};
        $self->{in}->{work_t}--;
    }
    elsif ( $self->{in}->{work} ) {
        $self->{out} .= '</a>';
        $self->{in}->{work}--;
    }
}

1
