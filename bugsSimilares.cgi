#!/usr/bin/perl
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# This Source Code Form is "Incompatible With Secondary Licenses", as
# defined by the Mozilla Public License, v. 2.0.
package Bugzilla::Extension::NextBug;
use lib '../../';

use strict;
use base qw(Bugzilla::Extension);
use lib qw(. lib);
use Bugzilla;
use GetSimilares;
use Bugzilla::Constants;
use Bugzilla::Error;
use Bugzilla::Util;
use Bugzilla::Field;
use Bugzilla::Token;

my $cgi                 = Bugzilla->cgi;
my $dbh                 = Bugzilla->dbh;                        # Conecta .
my $template            = Bugzilla->template;
my $vars                = {};
my $id                  = $cgi->param('id');
my $similarityThreshold = $cgi->param('similarityThreshold');
my $highestSeverity     = $cgi->param('highestSeverity');
my $lowestSeverity      = $cgi->param('lowestSeverity');
my $includeEnhancements = $cgi->param('includeEnhancements');
my $unassignedBugsOnly  = $cgi->param('unassignedBugsOnly');
my $didnotreport        = $cgi->param('didnotreport');
my $userId              = $cgi->param('iduser');
my $MaxRec              = $cgi->param('MaxRec');
my $compid              = $cgi->param('compid');

if ( $MaxRec eq "" ) {

	$MaxRec = 5;
}

my %hashRecomendacao = GetSimilares->getSimilares(
	$similarityThreshold, $highestSeverity,    $lowestSeverity,
	$includeEnhancements, $unassignedBugsOnly, $didnotreport,
	$id,                  $userId,             $compid,$MaxRec
);
my @v = keys(%hashRecomendacao);

my $tem = keys(%hashRecomendacao);

if ( $tem == 0 ) {
	print $cgi->header();
	my $vars =  { serial_no =>  '1', };
	$template->process( "pages/nextbug/bug.html.tmpl", $vars )
	  || die $template->error();
	
}

else {

	my $to;
	foreach $to (@v) {

	}

	print $cgi->header(),

	  my $i = 0;

	foreach my $data (
		sort { $hashRecomendacao{$b}->[2] <=> $hashRecomendacao{$a}->[2] }
		keys %hashRecomendacao )
	{
		
		my @data = $dbh->selectrow_array(
"select login_name, realname from profiles where userid = $hashRecomendacao{$data}->[4]"
		);    #pega o nome do usuario e o login
		my $similaridade = sprintf( "% .2f", $hashRecomendacao{$data}->[2] );
		$similaridade                 = $similaridade * 100;
		$hashRecomendacao{$data}->[6] = ( $data[1] );
		$hashRecomendacao{$data}->[7] = ( $data[0] );
		$hashRecomendacao{$data}->[8] =
"extensions/NextBug/lib/Redirects.cgi?idusu=$userId&idbugori=$id&idbugrecommended=$hashRecomendacao{$data}->[0]";

		$i++;
		
	
	}
	print $cgi->header();
	
	my $vars = { serial_no => \%hashRecomendacao, MaxRec => $MaxRec,};

	$template->process( "pages/nextbug/bug.html.tmpl", $vars )
	  || die $template->error();
}

