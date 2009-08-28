package HTML::Form::XSS;

=pod

=head1 NAME

HTML::Form::XSS - Test HTML forms for cross site scripting vulnerabilities.

=head1 Author

MacGyveR <dumb@cpan.org>

Development questions, bug reports, and patches are welcome to the above address

=head1 Copyright

Copyright (c) 2009 MacGyveR. All rights reserved.

This library is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

=cut

use strict;
use warnings;
use Data::Dumper;
use XML::Simple;
use Carp;
use HTML::Form::XSS::Result;
use base qw(HTML::XSSLint);	#we use this module as a base
our $VERSION = 0.1;
###################################
sub new{
	my($class, $mech, %params) = @_;
	my $self = {
		'_mech' => $mech,
		'_configFile' => $params{'config'}
	};
	bless $self, $class;
	$self->_loadConfig();
	return $self;
}
###################################
sub make_params {	#passing a check value here, so we can do many checks
    my($self, $check, @inputs) = @_;
    my %params;
    foreach my $input (@inputs){
    	if(defined($input->name()) && length($input->name())){
	    	my $value = $self->random_string();
	    	$params{$input->name()} = $check . $value;    		
    	}
    }
    return \%params;
}
#######################################################
sub do_audit {	#we do many checks here not just one
    my($self, $form) = @_;
    my @results;
   	print "Checking...";
    foreach my $check ($self->_getChecks()){
	    my $params = $self->make_params($check, $form->inputs);
	    my $request = $self->fillin_and_click($form, $params);
	    my $response = $self->request($request);
	    print " " . $response->code();
	    $response->is_success or confess("Can't fetch " . $form->action);	
	    my @names = $self->compare($response->content, $params);
    	my $result = DT::XSSLint::Result->new(	#using are modified result class
			form => $form,
			names => \@names,
			check => $check
    	);
    	push(@results, $result);
    }
    print "\n";
    return @results;
}
###################################
sub compare{	#we need tp make the patterns regex safe
    my($self, $html, $params) = @_;
    my @names;
    foreach my $param (keys(%{$params})){
    	my $pattern = $self->_makeRegexpSafe($params->{$param});
    	if($html =~ m/$pattern/){
    		push(@names, $param);
    	}
    }
    return @names;
}
###################################
sub _getChecks{
	my $self = shift;
	my $config = $self->_getConfig();
	my $checks = $config->{'checks'}->{'check'};
	return @{$checks};
}
###################################
sub _getConfigFile{
	my $self = shift;
	return $self->{'_configFile'};
}
###################################
sub _getConfig{
	my $self = shift;
	return $self->{'_config'};
}
###################################
sub _loadConfig{
	my $self = shift;
	my $file = $self->_getConfigFile();
	my $ref = XMLin($file);
	$self->{'_config'} = $ref;
	return 1;
}
###################################
sub _makeRegexpSafe{
	my($self, $pattern) = @_;
	$pattern =~ s/([\(\)])/\\$1/g;	#add back slashes where required
	return $pattern;
}
###################################
sub _getMech{
	my $self = shift;
	return $self->{'_mech'};
}
###################################
return 1;
