
# $Id: Makefile.PL,v 1.2 2000/06/02 10:57:27 trip Exp $

use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'NAME'		=> 'HTML::CGIChecker',
    'VERSION_FROM'	=> 'CGIChecker.pm', # finds $VERSION
    'PREREQ_PM'		=> {}, # e.g., Module::Name => 1.1
);
