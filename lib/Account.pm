use strict;
use warnings;

package Account;

my $assessment = 500;

sub new {
    my ($class, $account_number, $balance) = @_;
    my $self = {
        account_number => int($account_number),
        balance        => $balance
    };
    bless $self, $class;
    return $self;
}

sub deposit {
    my ($self, $value) = @_;
    $self->{balance} += $value;
}

sub debit {
    my ($self, $value) = @_;
    $self->{balance} -= $value;
    if ($self->{balance} < 0) {
        $self->{balance} -= $assessment;
    }
}

1;
