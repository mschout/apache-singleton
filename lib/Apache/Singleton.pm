package Apache::Singleton;

use strict;
use vars qw($VERSION);
$VERSION = '0.07';

BEGIN {
    my $delegator = sprintf 'Apache::Singleton::%s',
	$ENV{MOD_PERL} ? 'Request' : 'Process';
    eval qq{require $delegator};
    sub _delegator { $delegator }
}

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

# Abstract methods, but compatible default
sub _get_instance {
    my $class = shift;
    my $delegate = sprintf '%s::_get_instance', $class->_delegator;
    $class->$delegate(@_);
}

sub _set_instance {
    my $class = shift;
    my $delegate = sprintf '%s::_set_instance', $class->_delegator;
    $class->$delegate(@_);
}

1;
__END__

=head1 NAME

Apache::Singleton - Singleton class for mod_perl

=head1 SYNOPSIS

  package Printer;
  # default:
  #   Request for mod_perl env
  #   Process for non-mod_perl env
  use base qw(Apache::Singleton);

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
on each request. Implemented using mod_perl C<pnotes> API. In mod_perl
environment (where C<$ENV{MOD_PERL}> is defined), this is the default
scope, so inheriting from Apache::Singleton would do the same effect.

=item Process

  use base qw(Apache::Singleton::Process);

One instance for one httpd process. Implemented using package
global. In non-mod_perl environment, this is the default scope, and
you may notice this is the same beaviour with Class::Singleton ;)

So you can use this module safely under non-mod_perl environment.

=back

=head1 AUTHOR

Original idea by Matt Sergeant E<lt>matt@sergeant.orgE<gt> and Perrin
Harkins E<lt>perrin@elem.comE<gt>.

Code by Tatsuhiko Miyagawa E<lt>miyagawa@bulknews.netE<gt>.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

L<Apache::Singleton::Request>, L<Apache::Singleton::Process>,
L<Class::Singleton>

=cut
