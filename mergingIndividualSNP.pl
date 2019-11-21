#!/usr/bin/perl -w
use strict;

my @snpfiles=("sample01.gtp","sample02.gtp",
              "sample03.gtp","sample04.gtp",
              "sample05.gtp","sample06.gtp",
              "sample07.gtp","sample08.gtp",
              "sample09.gtp","sample10.gtp",
              "sample11.gtp","sample12.gtp",
              "sample13.gtp","sample14.gtp",
              "sample15.gtp","sample16.gtp",
              "sample17.gtp","sample18.gtp",
              "sample19.gtp","sample20.gtp");
my @fd;
my $key;
my $value;
my %hash0;
my %tmp;
my %hash;
my $i;

for($i=0;$i<20;$i++){
	open(IN,"<$snpfiles[$i]");
	while(<IN>){
		chop $_;
		@fd = split /\s+/,$_;
		$key = "$fd[0]\_$fd[1]";
		$hash0{$key} = ".";
	}
	close(IN);
}

open(IN,"<$snpfiles[0]");
%hash = %hash0;
while(<IN>){
	chop $_;
	@fd = split /\s+/,$_;
	$key = "$fd[0]\_$fd[1]";
	$hash{$key} = $fd[2];
}
close(IN);

for($i=1;$i<20;$i++){
	open(IN,"<$snpfiles[$i]");
	%tmp = %hash0;
	while(<IN>){
		chop $_;
		@fd = split /\s+/,$_;
		$key = "$fd[0]\_$fd[1]";
		$tmp{$key} = $fd[2];
	}
	close(IN);
	foreach $key (keys %hash){
		$hash{$key} = "$hash{$key}\t$tmp{$key}";
	}
}

foreach $key (sort { ($a=~/CLS(\d+)\_(\d+)/)[0] <=> ($b=~/CLS(\d+)\_(\d+)/)[0]
                     or ($a=~/CLS(\d+)\_(\d+)/)[1] <=> ($b=~/CLS(\d+)\_(\d+)/)[1]
       	} (keys %hash)){
	print "$key\t$hash{$key}\n";
}

exit;
