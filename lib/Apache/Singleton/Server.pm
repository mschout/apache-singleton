package Apache::Singleton::Server;

use strict;
use vars qw($VERSION);
$VERSION = '0.01';

use Apache::Singleton;
use base qw(Apache::Singleton::Process);

use Cache::SharedMemoryCache;

sub _get_instance {
    my $class = shift;

    # if we can get process based one, return it
    my $global = $class->SUPER::_get_instance;
    return $global if defined $global;

    # now get it from shared memory
    my $cache = Cache::SharedMemoryCache->new({
	namespace => 'apache_singleton',
    });
    my $shared = $cache->get($class);

    # no process based, but can get from shared memory
    $class->SUPER::_set_instance($shared) if defined $shared;

    return $shared;
}

sub _set_instance {
    my($class, $instance) = @_;

    # first, set process based one
    $class->SUPER::_set_instance($instance);

    my $cache = Cache::SharedMemoryCache->new({
	namespace => 'apache_singleton',
    });
    $cache->set($class => $instance);
}

1;
__END__

=head1 NAME

Apache::Singleton::Server - One instance per One Server

=head1 SYNOPSIS

  package Printer;
  use base qw(Apache::Singleton::Server);

=head1 DESCRIPTION

See L<Apache::Singleton>.

=head1 SEE ALSO

L<Apache::Singleton>

=cut
