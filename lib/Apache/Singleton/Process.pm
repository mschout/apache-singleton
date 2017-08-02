package Apache::Singleton::Process;

# ABSTRACT: One instance per One Process

use strict;
use warnings;

use base 'Apache::Singleton';

no strict 'refs';

my %INSTANCES;

sub _get_instance {
    my $class = shift;

    $class = ref $class || $class;

    return $INSTANCES{$class};
}

sub _set_instance {
    my($class, $instance) = @_;

    $class = ref $class || $class;

    $INSTANCES{$class} = $instance;
}

END {
    # dereferences and causes orderly destruction of all instances
    undef(%INSTANCES);
}

1;

__END__

=head1 SYNOPSIS

  package Printer;
  use base qw(Apache::Singleton::Process);

=head1 DESCRIPTION

See L<Apache::Singleton>.

=head1 SEE ALSO

L<Apache::Singleton>

=cut
