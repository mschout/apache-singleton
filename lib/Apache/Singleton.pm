package Apache::Singleton;

use strict;
use vars qw($VERSION);
$VERSION = '0.02';

use Apache;

sub instance {
    my $class = shift;

    my $r = Apache->request;
    my $key = "apache_singleton_$class";
    my $instance = $r->pnotes($key);

    unless (defined $instance) {
	$instance = $class->_new_instance(@_);
	$r->pnotes($key => $instance);
    }

    return $instance;
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

=head1 AUTHOR

Original idea by Matt Sergeant E<lt>matt@sergeant.orgE<gt> and Perrin
Harkins E<lt>perrin@elem.comE<gt>.

Code by Tatsuhiko Miyagawa E<lt>miyagawa@bulknews.netE<gt>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

L<Class::Singleton>

=cut
