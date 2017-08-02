# COPYRIGHT

package Apache::Singleton::Request;

# ABSTRACT: One instance per One Request

use strict;
use warnings;

use base 'Apache::Singleton';

BEGIN {
    use constant MP2 => $mod_perl::VERSION >= 1.99 ? 1 : 0;

    if (MP2) {
        require Apache2::RequestUtil;
    }
    else {
        require Apache;
    }
}

sub _get_instance {
    my $class = shift;
    my $r = MP2 ? Apache2::RequestUtil->request : Apache->request;
    my $key = "apache_singleton_$class";
    return $r->pnotes($key);
}

sub _set_instance {
    my($class, $instance) = @_;
    my $r = MP2 ? Apache2::RequestUtil->request : Apache->request;
    my $key = "apache_singleton_$class";
    $r->pnotes($key => $instance);
}

1;

__END__

=head1 SYNOPSIS

  # in httpd.conf
  PerlOptions +GlobalRequest

  # in your module (e.g.: Printer.pm)
  package Printer;
  use base qw(Apache::Singleton::Request);

=head1 DESCRIPTION

See L<Apache::Singleton>.

=head1 SEE ALSO

L<Apache::Singleton>

=cut
