#!/usr/bin/perl -w
use strict;

my $line;
my @fd;
my @allels;
my @fd9;
my ($a1,$a2);
my @dp;
my $gq;
my ($dp0,$dp1,$dp2);
my @gtp;


open(IN,"<$ARGV[0]");

while( $line = <IN>  ){
	if( $line =~ /^#/ ){   next;	}
	if( $line =~ /INDEL/ ){ next; }

	chop $line;
	@fd = split /\t/, $line;

	if( $fd[4] =~ /,/ ){
		@allels =  ($fd[3],(split /,/,$fd[4]) );
	}else{
		@allels = ($fd[3],$fd[4]);
	}

	@fd9 = split /:/,$fd[9];
	($a1,$a2) = split /\//,$fd9[0];
	@dp = split /,/,$fd9[2];
	$gq = $fd9[3];

	if($a1 == $a2){
		$dp0 = $dp[$a1];
		if($dp0 > 4){
			print "$fd[0]\t$fd[1]\t$allels[$a1]|$allels[$a2]\n";
		}
	}else{
		$dp1 = $dp[$a1];
		$dp2 = $dp[$a2];
		if($dp1 >= 3 && $dp2 >= 3 && $gq > 30){
			@gtp = sort ($allels[$a1],$allels[$a2]);
			print "$fd[0]\t$fd[1]\t$gtp[0]|$gtp[1]\n";
		}
	}
}


close(IN);
exit;
