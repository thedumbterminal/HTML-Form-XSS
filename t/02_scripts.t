use strict;
use warnings;
use Test::More;
use lib qw(lib ../lib);
plan(tests => 1);
chdir("script");
my $ok = 0;
if(open(TEST, "./check.pl 2>&1 |")){
	while(my $line = <TEST>){
		print $line;	#so we can see problems if any
		if($line =~ m/Usage/){
			$ok = 1;
		}
	}
	close(TEST);
}
else{
	die("Can't run ./check.pl: $!");
}
#1
ok($ok);