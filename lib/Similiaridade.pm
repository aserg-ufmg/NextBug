#!/perl/bin/perl
# package Mine::MyModule;
package Similiaridade;

use lib '../';
use Formula;

sub similiaridade {

	my @texto  = @{ $_[1] };
	my @texto1 = @{ $_[2] };

	my @resposta  = Formula::stemmmStopword(@texto);
	my @resposta1 = Formula::stemmmStopword(@texto1);

	my $teste = 1;
	$teste = Formula::cosineSimilar( \@resposta, \@resposta1 );



	return $teste;

}


1;
