use strict;

$ENV{MOD_PERL} = 1;
$INC{'Apache.pm'} = 1;		# dummy

package Printer;
use base qw(Apache::Singleton::Server);

sub _new_instance {
    bless { pid => $$ }, shift;
}

package main;
my $printer_a = Printer->instance;
my $printer_b = Printer->instance;


print <<EOF;
address: $printer_a - $printer_b
pid: $printer_a->{pid} - $printer_b->{pid}
EOF
    ;

