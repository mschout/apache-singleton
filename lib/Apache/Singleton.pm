package Apache::Singleton;

use strict;
use vars qw($VERSION);
$VERSION = '0.04';

require Apache::Singleton::Request;

sub instance {
    my $class = shift;

    my $instance = $class->_get_instance;
    unless (defined $instance) {
	$instance = $class->_new_instance(@_);
	$class->_set_instance($instance);
    }
    return $instance;
}

sub _new_instance {
    bless {}, shift;
}

# Abstract methods, but default is Request ;)
sub _get_instance {
    my $class = shift;
    $class->Apache::Singleton::Request::_get_instance(@_);
}

sub _set_instance {
    my $class = shift;
    $class->Apache::Singleton::Request::_set_instance(@_);
}

1;
__END__

=head1 NAME

Apache::Singleton - Singleton class for mod_perl

=head1 SYNOPSIS

  package Printer;
  use base qw(Apache::Singleton);

  # same: default is per Request
  package Printer::PerRequest;
  use base qw(Apache::Singleton::Request);

  package Printer::PerProcess;
  use base qw(Apache::Singleton::Process);

=head1 DESCRIPTION

Apache::Singleton works the same as Class::Singleton, but with
various object lifetime (B<scope>). See L<Class::Singleton> first.

=head1 OBJECT LIFETIME

By inheriting one of the following sublasses of Apache::Singleton,
you can change the scope of your object.

=over 4

=item Request

  use base qw(Apache::Singleton::Request);

One instance for one request. Apache::Singleton will remove instance
on each request. Implemented using mod_perl C<pnotes> API. This is the
default scope, so inheriting from Apache::Singleton would do the same
effect.

=item Process

  use base qw(Apache::Singleton::Process);

One instance for one httpd process. Implemented using package
global. Notice this is the same beaviour with Class::Singleton ;)

=back

=head1 AUTHOR

Original idea by Matt Sergeant E<lt>matt@sergeant.orgE<gt> and Perrin
Harkins E<lt>perrin@elem.comE<gt>.

Code by Tatsuhiko Miyagawa E<lt>miyagawa@bulknews.netE<gt>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

L<Apache::Singleton::Request>, L<Apache::Singleton::Process>,
L<Class::Singleton>, L<Cache::SharedMemoryCache>

=cut
