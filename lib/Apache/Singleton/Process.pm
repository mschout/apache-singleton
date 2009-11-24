package Apache::Singleton::Process;

use strict;
use base 'Apache::Singleton';

our $VERSION = '0.01';

no strict 'refs';

sub _get_instance {
    my $class = shift;
    my $global = "$class\::_instance";
    return $$global;
}

sub _set_instance {
    my($class, $instance) = @_;
    my $global = "$class\::_instance";
    $$global = $instance;
}

1;
__END__

=head1 NAME

Apache::Singleton::Process - One instance per One Process

=head1 SYNOPSIS

  package Printer;
  use base qw(Apache::Singleton::Process);

=head1 DESCRIPTION

See L<Apache::Singleton>.

=head1 SEE ALSO

L<Apache::Singleton>

=cut
