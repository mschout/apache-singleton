use strict;
use Test::More tests => 5;

use Cache::SharedMemoryCache;
my $cache = Cache::SharedMemoryCache->new({ namespace => 'apache_singleton' });
$cache->clear;

my $out1 = `$^X ./t/server.pl`;
my $out2 = `$^X ./t/server.pl`;

# same instance per process
for my $out ($out1, $out2) {
    my @addr = $out =~ /address: (.*?) - (.*)/;
    is $addr[0], $addr[1], $addr[0];
}

# same instance data acrooss prorcess
my @pid1 = $out1 =~ /pid: (\d+) - (\d+)/;
my @pid2 = $out2 =~ /pid: (\d+) - (\d+)/;

is $pid1[0], $pid1[1], "pid - $pid1[0]";
is $pid2[0], $pid2[1], "pid - $pid2[0]";
is $pid1[0], $pid2[0], "pid - $pid1[0]";




