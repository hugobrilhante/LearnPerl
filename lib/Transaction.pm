use strict;
use warnings;

package Transaction;

sub new {
    my ($class, $account_number, $value) = @_;
    my $self = {
        account_number => int($account_number),
        value => $value
    };
    bless $self, $class;
    return $self;
}

1;