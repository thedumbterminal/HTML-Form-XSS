use strict;
use warnings;
use Test::More;
plan(tests => 1);
chdir("script");
my $ok = 0;
open(TEST, "./check.pl 2>&1 |");
while(my $line = <TEST>){
	if($line =~ m/Usage/){
		$ok = 1;
	}
}
close(TEST);
#1
ok($ok);