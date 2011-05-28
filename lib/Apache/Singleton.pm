package Apache::Singleton;

# ABSTRACT: Singleton class for mod_perl

use strict;

unless ($ENV{MOD_PERL}) {
    require Apache::Singleton::Process;
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
    my $class = shift;

    my %args = (@_ && ref $_[0] eq 'HASH') ? %{ $_[0] } : @_;

    bless { %args }, $class;
}

# Abstract methods, but compatible default
sub _get_instance {
    my $class = shift;

    if ($ENV{MOD_PERL}) {
        $class->Apache::Singleton::Request::_get_instance(@_);
    }
    else {
        $class->Apache::Singleton::Process::_get_instance(@_);
    }
}

sub _set_instance {
    my $class = shift;

    if ($ENV{MOD_PERL}) {
        $class->Apache::Singleton::Request::_set_instance(@_);
    }
    else {
        $class->Apache::Singleton::Process::_set_instance(@_);
    }
}

1;
__END__

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

=head1 CREDITS

Original idea by Matt Sergeant E<lt>matt@sergeant.orgE<gt> and Perrin
Harkins E<lt>perrin@elem.comE<gt>.

Initial implementation and versions 0.01 to 0.07 by Tatsuhiko Miyagawa
E<lt>miyagawa@bulknews.netE<gt>.

=head1 SEE ALSO

L<Apache::Singleton::Request>, L<Apache::Singleton::Process>,
L<Class::Singleton>

=cut
