use strict;
use Test::More tests => 2;

$ENV{MOD_PERL} = 1;
$INC{'Apache.pm'} = 1;		# dummy

package Apache;
sub request {
    bless {}, 'Mock::Apache';
}

package Mock::Apache;
sub register_cleanup {
    my($self, $code) = @_;
    ::is ref($code), 'CODE';
}

package Printer;
use base qw(Apache::Singleton);

package main;
my $printer_a = Printer->instance;
my $printer_b = Printer->instance;

is "$printer_a", "$printer_b", 'same printer';




