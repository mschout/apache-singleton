package Apache::Singleton;

use strict;
use vars qw($VERSION);
$VERSION = '0.01';

sub instance {
    my $class = shift;

    # get a reference to the _instance variable in the $class package
    no strict 'refs';
    my $instance = "$class\::_instance";

    unless (defined $$instance) {
	$$instance = $class->_new_instance(@_);
	if ($ENV{MOD_PERL}) {
	    require Apache;
	    Apache->request->register_cleanup(sub { undef $$instance });
	}
    }

    return $$instance;
}

sub _new_instance {
    bless {}, shift;
}

1;
__END__

=head1 NAME

Apache::Singleton - Singleton class for mod_perl

=head1 SYNOPSIS

  package Printer;
  use base qw(Apache::Singleton);

  # just the same as Class::Singleton

=head1 DESCRIPTION

Apache::Singleton works the same as Class::Singleton, but clears the
singleton out on each request.

This module checks C<$ENV{MOD_PERL}>, so it just works well in
non-mod_perl environment.

=head1 AUTHOR

Original idea by Matt Sergeant E<lt>matt@sergeant.orgE<gt>.

Code by Tatsuhiko Miyagawa E<lt>miyagawa@bulknews.netE<gt>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

L<Class::Singleton>

=cut
