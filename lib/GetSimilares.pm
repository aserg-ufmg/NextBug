#!/usr/bin/perl

use lib '../';
use Similiaridade;
use Logging;
use Formula;

package GetSimilares;
use Bugzilla;
use Time::HiRes qw/ time sleep /;

sub getSimilares {
	my $start = time;

	my %hashRecomendacao;
	my $limitardeSimilaridade = 0.10;

	@ids                 = @_;        #deu 5 id = 974091;
	$similarityThreshold = @ids[1];
	my $highestSeverity     = @ids[2];
	my $lowestSeverity      = @ids[3];
	my $includeEnhancements = @ids[4];
	my $unassignedBugsOnly  = @ids[5];
	my $didnotreport        = @ids[6];
	$id     = @ids[7];
	$idUser = @ids[8];
	$compid = @ids[9];
	$MaxRec = @ids[10];
	if ( $similarityThreshold eq "" ) {

		$limitardeSimilaridade = 0.10;

	}
	else {

		$limitardeSimilaridade = $similarityThreshold / 100;

	}

	my $dbh = Bugzilla->dbh;    # Conecta .
	my @data =
	  $dbh->selectrow_array("select short_desc from bugs where bug_id =$id");
	my $customSql =
"select bug_id,short_desc,creation_ts,reporter from bugs where bug_id <>$id
 and (component_id = $compid or component_id is null)
 and (resolution = ' ' or resolution is null)";

	if ( $didnotreport eq "1" ) {

		$customSql = $customSql . "and  reporter <> $idUser";

	}

	if ( $includeEnhancements eq "0" ) {
		$customSql = $customSql . " and bug_severity <> 'enhancement' ";
	}

	if ( $unassignedBugsOnly eq "1" ) {
		$customSql = $customSql . " and assigned_to = 1 ";
	}

	if ( $highestSeverity eq "critical" ) {

		$customSql = $customSql . " and bug_severity <> 'blocker' ";
	}
	elsif ( $highestSeverity eq "major" ) {

		$customSql = $customSql
		  . " and bug_severity <> 'blocker' and bug_severity <> 'critical'  ";
	}
	elsif ( $highestSeverity eq "normal" ) {

		$customSql = $customSql
		  . " and bug_severity <> 'blocker' and bug_severity <> 'critical' and bug_severity <> 'major' ";
	}
	elsif ( $highestSeverity eq "Minor" ) {

		$customSql = $customSql
		  . " and bug_severity <> 'blocker' and bug_severity <> 'critical' and bug_severity <> 'major' and bug_severity <> 'normal' ";
	}
	elsif ( $highestSeverity eq "Trivial" ) {
		$customSql = $customSql
		  . " and bug_severity <> 'blocker' and bug_severity <> 'critical' and bug_severity <> 'major' and bug_severity <> 'normal' and 	bug_severity <> 'minor' "

	}

	if ( $lowestSeverity eq "minor" ) {

		$customSql = $customSql . "and bug_severity <> 'trivial' ";
	}
	elsif ( $lowestSeverity eq "normal" ) {

		$customSql = $customSql
		  . " and bug_severity <> 'trivial' and bug_severity <> 'minor'  "

	}
	elsif ( $lowestSeverity eq "major" ) {

		$customSql = $customSql
		  . " and bug_severity <> 'trivial' and bug_severity <> 'minor' and bug_severity <> 'normal'  "

	}
	elsif ( $lowestSeverity eq "critical" ) {

		$customSql = $customSql
		  . " and bug_severity <> 'trivial' and bug_severity <> 'minor' and bug_severity <> 'normal' and bug_severity <> 'major' "

	}
	elsif ( $lowestSeverity eq "blocker" ) {

		$customSql = $customSql
		  . " and bug_severity <> 'trivial' and bug_severity <> 'minor' and bug_severity <> 'normal' and bug_severity <> 'major' and 	   bug_severity <> 'critical' "

	}

	$customSql = $customSql . " order by creation_ts desc; ";

	my $data1 = $dbh->selectall_arrayref($customSql);

	@bugs = @$data1;

	#pecorre o vetor medindo a similaridade para ver se é maior que 0.1;

	my $i = 0;

	my @main_issue = split( ' ', $data[0] );    #bug passado por id

	foreach $data (@bugs) {
		my @texto1 = split( ' ', $bugs[$i]->[1] );

		$quantoSimilar = Similiaridade->similiaridade( \@main_issue, \@texto1 );

		if ( $quantoSimilar >= $limitardeSimilaridade ) {

			$hashRecomendacao{ $bugs[$i]->[0] }->[0] = $bugs[$i]->[0];
			$hashRecomendacao{ $bugs[$i]->[0] }->[1] = $bugs[$i]->[1];

			$hashRecomendacao{ $bugs[$i]->[0] }->[2] =
			  Similiaridade->similiaridade( \@main_issue, \@texto1 );

			$hashRecomendacao{ $bugs[$i]->[0] }->[3] = $bugs[$i]->[2];
			$hashRecomendacao{ $bugs[$i]->[0] }->[4] = $bugs[$i]->[3];

			$t = Similiaridade->similiaridade( \@main_issue, \@texto1 );

		}
		$i++;

		
	}

	foreach $data (
		sort { $hashRecomendacao{$b}->[2] <=> $hashRecomendacao{$a}->[2] }
		keys %hashRecomendacao
	  )
	{
	
	}

	my $end = time;

	my $total = $end - $start;
	$tota = sprintf( "%01.4f", $total );
	$loggingString = ";" . $idUser . ";" . $id . ";" . $tota;

	Logging->setLogging( $loggingString, "log/nextbug-performance.log" );

	return %hashRecomendacao;

}
getSimilares

  return 1;

