use ExtUtils::MakeMaker;
WriteMakefile(
    'NAME'      => 'Apache::Singleton',
    'VERSION_FROM' => 'lib/Apache/Singleton.pm', # finds $VERSION
    'PREREQ_PM' => {
	Test::More => 0.32,
	mod_perl => 0,
	Cache::Cache => 0.99,
    },
);
