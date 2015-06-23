#!/usr/bin/perl
#log4perl_easy3.pl

use strict;
use warnings;

package Logging;

sub setLogging {

	use Log::Log4perl qw(:easy);
	my @l = @_;

	my $v = "kjasjljdalsdlsad";

	my $file = $l[2];

	Log::Log4perl->easy_init(
		{
			level => $INFO,
			file  => ">> $file",
		},

	);
	INFO( $l[1] );

}

1;
