package DT::XSSLint::Result;
use strict;
use warnings;
use base qw(HTML::XSSLint::Result);
##############################################
sub check{	#accessor
	my $self = shift;
	return $self->{'check'};
}
###############################################
sub example {	#we should the actual check that we picked up
    my $self = shift;
    return undef unless $self->vulnerable;
    my $uri = URI->new($self->action);
    $uri->query_form(map { $_ => $self->check() } $self->names);
    return $uri;
}
##############################################
return 1;
