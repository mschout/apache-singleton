use strict;
use Test::More tests => 1;

$ENV{MOD_PERL} = 1;
$INC{'Apache.pm'} = 1;		# dummy

package Apache;
sub request {
    bless {}, 'Mock::Apache';
}

package Mock::Apache;
my %pnotes;
sub pnotes {
    my($self, $key, $val) = @_;
    $pnotes{$key} = $val if $val;
    return $pnotes{$key};
}

package Printer;
use base qw(Apache::Singleton);

package main;
my $printer_a = Printer->instance;
my $printer_b = Printer->instance;

is "$printer_a", "$printer_b", 'same printer';




