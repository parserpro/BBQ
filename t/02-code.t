#!perl -T
use 5.010;
use strict;
use warnings FATAL => 'all';
use Test::More;
use utf8;

plan tests => 8;

use_ok( 'BBQ' ) || print "Bail out!\n";

my $text = 'pre [code=Примерчик]<xml> [comment][b]test[/b][/code] past';
my $bbq = BBQ->new;
my $out = $bbq->parse($text);
is($out, 'pre <fieldset class="quote pre"><legend>Примерчик</legend>&lt;xml&gt; &#091;comment&#093;&#091;b&#093;test&#091;/b&#093;</fieldset> past', 'Simple [code]');

my $text2 = q~Имеем траблу с парсингом ссылок внутри блока code [code=Code]<a href='http://fantlab.ru' title='Laboratory SF&Fantasy'><img src='http://fantlab.ru/images/flbutton.gif' width=99 height=75 border=0></a>[/code]~;
my $out2 = $bbq->parse($text2);
is($out2, q~Имеем траблу с парсингом ссылок внутри блока code <fieldset class="quote pre"><legend>Code</legend>&lt;a href='http://fantlab.ru' title='Laboratory SF&Fantasy'&gt;&lt;img src='http://fantlab.ru/images/flbutton.gif' width=99 height=75 border=0&gt;&lt;/a&gt;</fieldset>~, 'Mix with link');

my $text3 = q~Имеем траблу с парсингом ссылок внутри блока code [code=Code]&lt;a href='http://fantlab.ru' title='Laboratory SF&Fantasy'&gt;&lt;img src='http://fantlab.ru/images/flbutton.gif' width=99 height=75 border=0&gt;&lt;/a&gt;[/code]~;
my $out3 = $bbq->parse(
    $text3,
    debug => 0,
);
is($out3, q~Имеем траблу с парсингом ссылок внутри блока code <fieldset class="quote pre"><legend>Code</legend>&lt;a href='http://fantlab.ru' title='Laboratory SF&Fantasy'&gt;&lt;img src='http://fantlab.ru/images/flbutton.gif' width=99 height=75 border=0&gt;&lt;/a&gt;</fieldset>~, 'Mix with link 2');

my $text4 = q~Имеем траблу с парсингом ссылок внутри блока code [code=Code]&lt;a href='http://fantlab.ru' title='Laboratory SF&amp;Fantasy'&gt;&lt;img src='http://fantlab.ru/images/flbutton.gif' width=99 height=75 border=0&gt;&lt;/a&gt;[/code]~;
my $out4 = $bbq->parse(
    $text4,
    set   => [qw(* b i u s p q h list img genre url code)],
    debug => 0,
    links => 1,
);
is($out4, q~Имеем траблу с парсингом ссылок внутри блока code <fieldset class="quote pre"><legend>Code</legend>&lt;a href='http://fantlab.ru' title='Laboratory SF&amp;Fantasy'&gt;&lt;img src='http://fantlab.ru/images/flbutton.gif' width=99 height=75 border=0&gt;&lt;/a&gt;</fieldset>~, 'Mix with links and "link" param and &lt;');

my $text5 = q~Имеем траблу с парсингом ссылок внутри блока code [code=Code]<a href='http://fantlab.ru' title='Laboratory SF&amp;Fantasy'><img src='http://fantlab.ru/images/flbutton.gif' width=99 height=75 border=0></a>[/code]~;
my $out5 = $bbq->parse(
    $text5,
    set   => [qw(* b i u s p q h list img genre url code)],
    debug => 0,
    links => 1,
);
is($out5, q~Имеем траблу с парсингом ссылок внутри блока code <fieldset class="quote pre"><legend>Code</legend>&lt;a href='http://fantlab.ru' title='Laboratory SF&amp;Fantasy'&gt;&lt;img src='http://fantlab.ru/images/flbutton.gif' width=99 height=75 border=0&gt;&lt;/a&gt;</fieldset>~, 'Mix with links and "link" param and <');

my $text6 = q~<div style="margin:8px 3px 0"><a href="http://fantlab.ru/work9452"><img src="http://fantlab.ru/rating/9452.gif" border="0"></a></div>~;
my $out6 = $bbq->parse(
    $text6,
    set   => [qw(* b i u s p q h list img genre url code)],
    debug => 0,
    links => 1,
);
is($out6, '<div style="margin:8px 3px 0"><a href="<a target="_blank" rel="nofollow" href="http://fantlab.ru/work9452">http://fantlab.ru/work9452</a>"><img src="<a target="_blank" rel="nofollow" href="http://fantlab.ru/rating/9452.gif">http://fantlab.ru/rating/9452.gif</a>" border="0"></a></div>', 'New example with links, not an error!!!');

my $text7 = q~<font color=gray>[= В глубь веков; Машина для перемещения во времени; Через 800 000 лет. Машина времени]</font>~;
my $out7 = $bbq->parse(
    $text7,
    set   => [qw(* b i u s p q h list img genre url code)],
    debug => 0,
    links => 1,
    leave => 1,
);
is($out7, '<font color=gray>[= В глубь веков; Машина для перемещения во времени; Через 800 000 лет. Машина времени]</font>', 'No cut unknown tag');
