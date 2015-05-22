package BBQ::Tags::color;
use common::sense;

my %colors = map { $_ => 1 } qw(snow ghostwhite whitesmoke gainsboro floralwhite oldlace linen antiquewhite papayawhip blanchedalmond bisque peachpuff navajowhite moccasin cornsilk
  ivory lemonchiffon seashell honeydew mintcream azure aliceblue lavender lavenderblush mistyrose white black darkslategray dimgrey slategrey lightslategray grey lightgray
  midnightblue navyblue cornflowerblue darkslateblue slateblue mediumslateblue lightslateblue mediumblue royalblue blue dodgerblue deepskyblue skyblue lightskyblue steelblue
  lightsteelblue lightblue powderblue paleturquoise darkturquoise mediumturquoise turquoise cyan lightcyan cadetblue mediumaquamarine aquamarine darkgreen darkolivegreen
  darkseagreen seagreen mediumseagreen lightseagreen palegreen springgreen lawngreen green chartreuse medspringgreen greenyellow limegreen yellowgreen forestgreen olivedrab
  darkkhaki palegoldenrod ltgoldenrodyello lightyellow yellow gold lightgoldenrod goldenrod darkgoldenrod indianred saddlebrown sienna peru burlywood beige wheat sandybrown tan
  chocolate firebrick brown darksalmon salmon lightsalmon orange darkorange coral lightcoral tomato orangered red hotpink deeppink pink lightpink palevioletred maroon mediumvioletred
  violetred magenta violet plum orchid mediumorchid darkorchid darkviolet blueviolet purple mediumpurple thistle snow1 snow2 snow3 snow4 seashell1 seashell2 seashell3 seashell4
  antiquewhite1 antiquewhite2 antiquewhite3 antiquewhite4 bisque1 bisque2 bisque3 bisque4 peachpuff1 peachpuff2 peachpuff3 peachpuff4 navajowhite1 navajowhite2 navajowhite3
  navajowhite4 lemonchiffon1 lemonchiffon2 lemonchiffon3 lemonchiffon4 cornsilk1 cornsilk2 cornsilk3 cornsilk4 vory1 vory2 ivory3 ivory4 honeydew1 honeydew2 honeydew3 honeydew4
  lavenderblush1 lavenderblush2 lavenderblush3 lavenderblush4 mistyrose1 mistyrose2 mistyrose3 mistyrose4 azure1 azure2 azure3 azure4 slateblue1 slateblue2 slateblue3 slateblue4
  royalblue1 royalblue2 royalblue3 royalblue4 blue1 blue2 blue3 blue4 dodgerblue1 dodgerblue2 dodgerblue3 dodgerblue4 steelblue1 steelblue2 steelblue3 steelblue4 deepskyblue1
  deepskyblue2 deepskyblue3 deepskyblue4 skyblue1 skyblue2 skyblue3 skyblue4 lightskyblue1 lightskyblue2 lightskyblue3 lightskyblue4 slategray1 slategray2 slategray3 slategray4
  lightsteelblue1 lightsteelblue2 lightsteelblue3 lightsteelblue4 lightblue1 lightblue2 lightblue3 lightblue4 lightcyan1 lightcyan2 lightcyan3 lightcyan4 paleturquoise1 paleturquoise2
  paleturquoise3 paleturquoise4 cadetblue1 cadetblue2 cadetblue3 cadetblue4 turquoise1 turquoise2 turquoise3 turquoise4 cyan1 cyan2 cyan3 cyan4 darkslategray1 darkslategray2
  darkslategray3 darkslategray4 aquamarine1 aquamarine2 aquamarine3 aquamarine4 darkseagreen1 darkseagreen2 darkseagreen3 darkseagreen4 seagreen1 seagreen2 seagreen3 seagreen4
  palegreen1 palegreen2 palegreen3 palegreen4 springgreen1 springgreen2 springgreen3 springgreen4 green1 green2 green3 green4 chartreuse1 chartreuse2 chartreuse3 chartreuse4
  olivedrab1 olivedrab2 olivedrab3 olivedrab4 darkolivegreen1 darkolivegreen2 darkolivegreen3 darkolivegreen4 khaki1 khaki2 khaki3 khaki4 lightgoldenrod1 lightgoldenrod2
  lightgoldenrod3 lightgoldenrod4 lightyellow1 lightyellow2 lightyellow3 lightyellow4 yellow1 yellow2 yellow3 yellow4 gold1 gold2 gold3 gold4 goldenrod1 goldenrod2 goldenrod3
  goldenrod4 darkgoldenrod1 darkgoldenrod2 darkgoldenrod3 darkgoldenrod4 rosybrown1 rosybrown2 rosybrown3 rosybrown4 indianred1 indianred2 indianred3 indianred4 sienna1 sienna2
  sienna3 sienna4 burlywood1 burlywood2 burlywood3 burlywood4 wheat1 wheat2 wheat3 wheat4 tan1 tan2 tan3 tan4 chocolate1 chocolate2 chocolate3 chocolate4 firebrick1 firebrick2
  firebrick3 firebrick4 brown1 brown2 brown3 brown4 salmon1 salmon2 salmon3 salmon4 lightsalmon1 lightsalmon2 lightsalmon3 lightsalmon4 orange1 orange2 orange3 orange4 darkorange1
  darkorange2 darkorange3 darkorange4 coral1 coral2 coral3 coral4 tomato1 tomato2 tomato3 tomato4 orangered1 orangered2 orangered3 orangered4 red1 red2 red3 red4 deeppink1 deeppink2
  deeppink3 deeppink4 hotpink1 hotpink2 hotpink3 hotpink4 pink1 pink2 pink3 pink4 lightpink1 lightpink2 lightpink3 lightpink4 palevioletred1 palevioletred2 palevioletred3
  palevioletred4 maroon1 maroon2 maroon3 maroon4 violetred1 violetred2 violetred3 violetred4 magenta1 magenta2 magenta3 magenta4 orchid1 orchid2 orchid3 orchid4 plum1 plum2 plum3
  plum4 mediumorchid1 mediumorchid2 mediumorchid3 mediumorchid4 darkorchid1 darkorchid2 darkorchid3 darkorchid4 purple1 purple2 purple3 purple4 mediumpurple1 mediumpurple2
  mediumpurple3 mediumpurple4 thistle1 thistle2 thistle3 thistle4 grey11 grey21 grey31 grey41 grey51 grey61 grey71 gray81 gray91 darkgrey darkblue darkcyan darkmagenta darkred
  lightgreen
);

=head1 NAME

BBQ::Tags::color

=head1 VERSION

Version 0.01

=head2 open
=cut

sub open {
    my ($self, $arg) = @_;
    $arg = lc $arg;

    return 0 unless $colors{$arg} || $arg =~ /^#[0-9ABCDEF]{1,6}$/i;

    $self->{out} .= qq~<span style="color:$arg">~;
    $self->{in}->{color}++;
    1;
}

=head2 close
=cut

sub close {
    my $self = shift;
    return unless $self->{in}->{color};
    $self->{out} .= '</span>';
    $self->{in}->{color}--;
}

1;