
BEGIN {
    unless ("A" eq pack('U', 0x41)) {
	print "1..0 # Unicode::Collate " .
	    "cannot stringify a Unicode code point\n";
	exit 0;
    }
    if ($ENV{PERL_CORE}) {
	chdir('t') if -d 't';
	@INC = $^O eq 'MacOS' ? qw(::lib) : qw(../lib);
    }
}

use Test;
BEGIN { plan tests => 83 };

use strict;
use warnings;
use Unicode::Collate::Locale;

ok(1);

#########################

my $uuml = pack 'U', 0xFC;
my $Uuml = pack 'U', 0xDC;
my $arng = pack 'U', 0xE5;
my $Arng = pack 'U', 0xC5;
my $auml = pack 'U', 0xE4;
my $Auml = pack 'U', 0xC4;
my $ae   = pack 'U', 0xE6;
my $AE   = pack 'U', 0xC6;
my $ouml = pack 'U', 0xF6;
my $Ouml = pack 'U', 0xD6;
my $ostk = pack 'U', 0xF8;
my $Ostk = pack 'U', 0xD8;

my $objFiPhone = Unicode::Collate::Locale->
    new(locale => 'FI__phonebook', normalization => undef);

ok($objFiPhone->getlocale, 'fi__phonebook');

$objFiPhone->change(level => 1);

ok($objFiPhone->lt('z', $arng));
ok($objFiPhone->lt($arng, $auml));
ok($objFiPhone->lt($auml, $ouml));
ok($objFiPhone->lt($ouml, "\x{1C0}"));

# 6

ok($objFiPhone->eq("d\x{335}", "\x{111}"));
ok($objFiPhone->eq("g\x{335}", "\x{1E5}"));
ok($objFiPhone->eq("n\x{335}", "\x{14B}"));
ok($objFiPhone->eq("t\x{335}", "\x{167}"));
ok($objFiPhone->eq("z\x{335}", "\x{292}"));
ok($objFiPhone->lt('v', 'w'));
ok($objFiPhone->eq('y', $uuml));
ok($objFiPhone->eq($auml, $ae));
ok($objFiPhone->eq($ouml, $ostk));

# 15

$objFiPhone->change(level => 2);

ok($objFiPhone->lt("d\x{335}", "\x{111}"));
ok($objFiPhone->lt("g\x{335}", "\x{1E5}"));
ok($objFiPhone->lt("n\x{335}", "\x{14B}"));
ok($objFiPhone->lt("t\x{335}", "\x{167}"));
ok($objFiPhone->lt("z\x{335}", "\x{292}"));
ok($objFiPhone->lt('v', 'w'));
ok($objFiPhone->lt('y', $uuml));
ok($objFiPhone->lt($auml, $ae));
ok($objFiPhone->lt($ouml, $ostk));

# 24

ok($objFiPhone->eq("\x{111}", "\x{110}"));
ok($objFiPhone->eq("\x{1E5}", "\x{1E4}"));
ok($objFiPhone->eq("\x{14B}", "\x{14A}"));
ok($objFiPhone->eq("\x{167}", "\x{166}"));
ok($objFiPhone->eq("\x{292}", "\x{1B7}"));
ok($objFiPhone->eq('w',   'W'));
ok($objFiPhone->eq($uuml, $Uuml));
ok($objFiPhone->eq($arng, $Arng));
ok($objFiPhone->eq($auml, $Auml));
ok($objFiPhone->eq($ae,   $AE));
ok($objFiPhone->eq($AE, "\x{1D2D}"));
ok($objFiPhone->eq($ouml, $Ouml));
ok($objFiPhone->eq($ostk, $Ostk));

# 37

$objFiPhone->change(level => 3);

ok($objFiPhone->lt("\x{111}", "\x{110}"));
ok($objFiPhone->lt("\x{1E5}", "\x{1E4}"));
ok($objFiPhone->lt("\x{14B}", "\x{14A}"));
ok($objFiPhone->lt("\x{167}", "\x{166}"));
ok($objFiPhone->lt("\x{292}", "\x{1B7}"));
ok($objFiPhone->lt('w',   'W'));
ok($objFiPhone->lt($uuml, $Uuml));
ok($objFiPhone->lt($arng, $Arng));
ok($objFiPhone->lt($auml, $Auml));
ok($objFiPhone->lt($ae,   $AE));
ok($objFiPhone->lt($AE, "\x{1D2D}"));
ok($objFiPhone->lt($ouml, $Ouml));
ok($objFiPhone->lt($ostk, $Ostk));

# 50

ok($objFiPhone->eq("u\x{308}", $uuml));
ok($objFiPhone->eq("U\x{308}", $Uuml));
ok($objFiPhone->eq("\x{1EF}", "\x{292}\x{30C}"));
ok($objFiPhone->eq("\x{1EE}", "\x{1B7}\x{30C}"));
ok($objFiPhone->eq("a\x{30A}", $arng));
ok($objFiPhone->eq("A\x{30A}", $Arng));
ok($objFiPhone->eq("a\x{308}", $auml));
ok($objFiPhone->eq("A\x{308}", $Auml));
ok($objFiPhone->eq("o\x{308}", $ouml));
ok($objFiPhone->eq("O\x{308}", $Ouml));
ok($objFiPhone->eq("o\x{338}", $ostk));
ok($objFiPhone->eq("O\x{338}", $Ostk));

# 62

ok($objFiPhone->eq("u\x{308}\x{300}", "\x{1DC}"));
ok($objFiPhone->eq("U\x{308}\x{300}", "\x{1DB}"));
ok($objFiPhone->eq("u\x{308}\x{301}", "\x{1D8}"));
ok($objFiPhone->eq("U\x{308}\x{301}", "\x{1D7}"));
ok($objFiPhone->eq("u\x{308}\x{304}", "\x{1D6}"));
ok($objFiPhone->eq("U\x{308}\x{304}", "\x{1D5}"));
ok($objFiPhone->eq("u\x{308}\x{30C}", "\x{1DA}"));
ok($objFiPhone->eq("U\x{308}\x{30C}", "\x{1D9}"));
ok($objFiPhone->eq("A\x{30A}", "\x{212B}"));
ok($objFiPhone->eq("a\x{30A}\x{301}", "\x{1FB}"));
ok($objFiPhone->eq("A\x{30A}\x{301}", "\x{1FA}"));
ok($objFiPhone->eq("a\x{308}\x{304}", "\x{1DF}"));
ok($objFiPhone->eq("A\x{308}\x{304}", "\x{1DE}"));
ok($objFiPhone->eq("\x{1FD}", "$ae\x{301}"));
ok($objFiPhone->eq("\x{1FC}", "$AE\x{301}"));
ok($objFiPhone->eq("\x{1E3}", "$ae\x{304}"));
ok($objFiPhone->eq("\x{1E2}", "$AE\x{304}"));
ok($objFiPhone->eq("o\x{308}\x{304}", "\x{22B}"));
ok($objFiPhone->eq("O\x{308}\x{304}", "\x{22A}"));
ok($objFiPhone->eq("o\x{338}\x{301}", "\x{1FF}"));
ok($objFiPhone->eq("O\x{338}\x{301}", "\x{1FE}"));

# 83
