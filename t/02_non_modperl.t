use strict;
use Test::More tests => 1;

package Apache;
sub request {
    bless {}, 'Mock::Apache';
}

package Mock::Apache;
sub register_cleanup {
    my($self, $code) = @_;
    ::fail "don't come here";
}

package Printer;
use base qw(Apache::Singleton);

package main;
my $printer_a = Printer->instance;
my $printer_b = Printer->instance;

is "$printer_a", "$printer_b", 'same printer';








