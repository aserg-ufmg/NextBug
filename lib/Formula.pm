#!/perl/bin/perl
# package Mine::MyModule;
package Formula;
use Lingua::Stem::Snowball;
use Lingua::StopWords qw( getStopWords );
use warnings;
use strict;

my $i = 1;
my %ni;

my $N = 0;

our $stemmer = Lingua::Stem::Snowball->new(
	lang     => 'en',
	encoding => 'UTF-8',
);
die $@ if $@;

my $stopwords = getStopWords( 'en', 'UTF-8' );

sub stemmmStopword {

	my @words_array = @_;

	my @resp_stemm = $stemmer->stem( [@words_array] );

	my @resposta = grep { !$stopwords->{$_} } @resp_stemm,
	  ;    # Vetor @bug onde fica armazenado o texto final

	return @resposta;

}

sub documentFrequency {
	my %tf;
	foreach my $word (@_) {

		if ( $word ne '' ) {

			if ( defined( $tf{$word} ) && ( $tf{$word}->[0] eq $word ) ) {
				my $temp1 = $tf{$word}->[1] + 1;
				$tf{$word} = [ $word, $temp1 ];

			}
			else {
				$tf{$word} = [ $word, 1 ];

				if (   defined( $ni{$word} )
					&& $ni{$word}->[0] eq $word
					&& ( $word ne '' ) )
				{

					my $temp = $ni{$word}->[1] + 1;
					$ni{$word} = [ $word, $temp ];

				}
				elsif ( $word ne '' ) {

					$ni{$word} = [ $word, 1 ];
				}

			}

		}

	}

	$N++;
	return %tf;
}

sub ajustePeso {
	my %pesoAjustado;

	my %tf = documentFrequency(@_);

	my @keys = keys(%tf);

	foreach my $key (@keys) {

		$pesoAjustado{$key} =
		  [ ( 1 + log( 1 + $tf{$key}->[1] ) ) * log( 1 + $N / $ni{$key}->[1] )
		  ];

	}

	return %pesoAjustado;
}

sub cosineSimilar {

	my @queryPrincipal = @{ $_[0] };
	my @otherBug       = @{ $_[1] };
	my %weightQuery    = ajustePeso(@queryPrincipal);

	my %weightOther = ajustePeso(@otherBug);
	my @keys        = keys(%weightQuery);

	my $tempz = 0;
	foreach my $key (@keys) {

		if ( defined( $weightOther{$key} ) ) {
			$tempz =
			  $tempz + ( $weightOther{$key}->[0] * $weightQuery{$key}->[0] );

		}

	}

	my $temp1 = 0;
	my $temp2 = 0;
	foreach my $key (@keys) {

		if ( defined( $weightQuery{$key} ) ) {

			$temp2 = $temp2 + ( $weightQuery{$key}->[0]**2 );

		}

	}

	@keys = keys(%weightOther);

	foreach my $key (@keys) {

		if ( defined( $weightOther{$key} ) ) {

			$temp1 = $temp1 + ( $weightOther{$key}->[0]**2 );

		}

	}

	$temp1 = sqrt($temp1);
	$temp2 = sqrt($temp2);

	my $result = $tempz / ( $temp1 * $temp2 );

	return $result;
}

