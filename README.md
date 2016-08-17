# HTML::Form::XSS

## Usage

    cd script
    ./check.pl http://www.targetsite.com/pagewithform.html

## Installation

### Via CPAN/CPANM

    cpan HTML::Form::XSS
    cpanm HTML::Form::XSS
    
### Manually

You install this as you would install any perl module
library, by running these commands:

    perl Build.PL
    ./Build installdeps
    ./Build
    ./Build test
    ./Build install

## Todo

Use javascript for better XSS detection with Mozilla::Mechanize.
Don't run all tests before giving results, bail out at first success.

## Credits

http://search.cpan.org/~miyagawa/HTML-XSSLint-0.01/lib/HTML/XSSLint.pm
http://ha.ckers.org/xss.html
