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

    my $data = ( $translators
                  ? 'перевод ' .
                    join(
                        ', ',
                        map {
                            "<a href=\"/translator$_\">" .
                            BD::Person->get_person_name_rp($_, 'translator') .
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
                            "<a href=\"/art$_\">" . BD::Person->get_person_name_rp($_, 'art') . '</a>'
                        }
                        grep { $_ }
                        split ',', $arts
                    )
                  : ''
               );

    $self->{in}->{work_t_data} = $data ? " ($data)" : '';
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
        $self->{out} .= '</a></span> ';
        $self->{out} .= delete $self->{in}->{work_t_data};
        $self->{in}->{work_t}--;
    }
    elsif ( $self->{in}->{work} ) {
        $self->{out} .= '</a></span>';
        $self->{in}->{work}--;
    }
}

1
