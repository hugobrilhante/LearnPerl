use strict;
use warnings;
use Account;
use Transaction;

package Bank;

sub new {
    my ($class, $account_file, $transaction_file) = @_;
    my $self = {
        accounts => {},
        transactions => {}
    };
    bless $self, $class;

    open my $fh, '<', $account_file or die "Não foi possível abrir o arquivo $account_file: $!";
    while (my $line = <$fh>) {
        chomp $line;
        my ($a, $b) = split(/,/, $line);
        $self->register_account(Account->new($a, $b));
    }
    close $fh;

    open $fh, '<', $transaction_file or die "Não foi possível abrir o arquivo $transaction_file: $!";
    while (my $line = <$fh>) {
        chomp $line;
        my ($a, $v) = split(/,/, $line);
        $self->register_transaction(Transaction->new($a, $v));
    }
    close $fh;

    return $self;
}

sub calculate_balances {
    my ($self) = @_;
    for my $account_number (keys %{$self->{accounts}}) {
        my $transactions = $self->get_transactions($account_number);
        for my $transaction (@{$transactions}) {
            my $value = int($transaction->{value});
            if ( $value > 0) {
                $self->{accounts}->{$account_number}->deposit($value);
            } else {
                $self->{accounts}->{$account_number}->debit($value);
            }
        }
    }
}

sub get_account {
    my ($self, $account_number) = @_;
    return $self->{accounts}->{$account_number};
}

sub get_balances {
    my ($self) = @_;
    for my $account (values %{$self->{accounts}}) {
        print join(',', $account->{account_number}, $account->{balance}), "\n";
    }
}

sub get_transactions {
    my ($self, $account_number) = @_;
    return $self->{transactions}->{$account_number};
}

sub register_account {
    my ($self, $account) = @_;
    $self->{accounts}->{$account->{account_number}} = $account;
}

sub register_transaction {
    my ($self, $transaction) = @_;
    my $account_number = $transaction->{account_number};
    if (not exists $self->{transactions}->{$account_number}) {
        $self->{transactions}->{$account_number} = [$transaction];
    } else {
        push @{$self->{transactions}->{$account_number}}, $transaction;
    }
}

1;
