package BBQ::Tags::biblio;
use common::sense;
use Helpers::Default;

sub open {
    my ($self, $arg) = @_;
    my $autor_id = $arg;

    my $autor_info = BD::Person->get_autor_block_info($autor_id);

    # дата рождения
    my $birthdate;
    if ( $autor_info->{birthday} ) {
        $birthdate = Helpers::Default->format_date($autor_info->{birthday});
    }
    if ( $autor_info->{deathday} ) {
        $birthdate .= " - " . Helpers::Default->format_date($autor_info->{deathday});
    }
    my $num = Helpers::Default->number( $autor_info->{age}, 'год', 'года', 'лет');
    $birthdate .= " ($num)";

    # жанры
    my $genres_str;
    my $autor_genres = BD::Author->get_autor_genres($autor_id);
    foreach my $genre (@$autor_genres) {
        $genres_str .= ", " if $genres_str;
        $genres_str .= "$genre->{name}";
    }
    $genres_str = "<p><b>Жанры:</b> $genres_str</p>" if $genres_str;

    my $html = qq{
        <table class="biblio-block-full" style="min-height:100px;">
          <tr>
            <td class="biblio-block-cover">
              <a href="/autor$autor_id"><img src="http://data.fantlab.ru/images/autors/$autor_id"></a>
            </td>
            <td class="biblio-block-descr">
              <div>
                <span><a href="/autor$autor_id"><b>$autor_info->{name}</b></a></span>
                <span hidden>№1</span>
                <br clear="all">
              </div>
              <div>
                <p><img src="http://data.fantlab.ru/images/flags/1.png"> Россия</p>
                <p>$birthdate</p>
                $genres_str
                <p style="color: gray"><b>Награды:</b> Лауреат <a href="http://fantlab.ru/award74#c1626">Нобелевской премии по литературе</a></p>
                <p style="color: gray"><b>Знаменитые произведения:</b> <i><a href="http://fantlab.ru/work28169">"Сто лет одиночества"</a>, <a href="http://fantlab.ru/work28165">"Полковнику никто не пишет"</a>.</i></p>
              </div>
              <div></div>
            </td>
          </tr>
        </table>
    };
    $self->{out} .= $html;
    $self->{in}->{biblio}++;
}

sub close {
    my $self = shift;
    return unless $self->{in}->{biblio};
    #$self->{out} .= '</a>';
    $self->{in}->{biblio}--;
}

1;