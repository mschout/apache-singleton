use ExtUtils::MakeMaker;

my %conf = (
    NAME         => 'Apache::Singleton',
    VERSION_FROM => 'lib/Apache/Singleton.pm',
    PREREQ_PM    => {
        'Test::More' => 0.32,
        'mod_perl2'   => 0,
    }
);

if ($] >= 5.005) {
    $conf{ABSTRACT_FROM} = 'lib/Apache/Singleton.pm';
    $conf{AUTHOR}        = 'Michael Schout <mschout@cpan.org>';
}

if ($ExtUtils::MakeMaker::VERSION >= 6.48) {
    $conf{META_MERGE} = {
        no_index => { directory => [qw(t)] },
        resources => {
            bugtracker => 'http://rt.cpan.org/NoAuth/Bugs.html?Dist=Apache-Singleton',
            repository => 'http://github.com/mschout/apache-singleton',
            homepage   => 'http://github.com/mschout/apache-singleton/downloads'
        }
    };
}

WriteMakefile(%conf);
