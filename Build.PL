use strict;
use warnings;
use Module::Build;
my $build = Module::Build->new(
	module_name => 'HTML::Form::XSS',
	license => 'perl',
	dist_author => 'MacGyveR <dumb@cpan.org>',
	requires => {
		"Carp" => "",
		"Data::Dumper" => "",
		"XML::Simple" => "",
		"HTML::XSSLint::Result" => ""
	},
	build_requires => {
		"Test::More" => "",
		"WWW::Mechanize" => "",
		"HTML::Form" => ""
	},
	create_makefile_pl => 'traditional'
);
$build->create_build_script;
