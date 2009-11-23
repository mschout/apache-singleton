package Apache::Singleton::Request;

use strict;
use vars qw($VERSION);
$VERSION = '0.01';

use Apache::Singleton;
use base qw(Apache::Singleton);

use Apache;

sub _get_instance {
    my $class = shift;
    my $r = Apache->request;
    my $key = "apache_singleton_$class";
    return $r->pnotes($key);
}

sub _set_instance {
    my($class, $instance) = @_;
    my $r = Apache->request;
    my $key = "apache_singleton_$class";
    $r->pnotes($key => $instance);
}

1;
__END__

=head1 NAME

Apache::Singleton::Request - One instance per One Request

=head1 SYNOPSIS

  package Printer;
  use base qw(Apache::Singleton::Request);

=head1 DESCRIPTION

See L<Apache::Singleton>.

=head1 SEE ALSO

L<Apache::Singleton>

=cut
