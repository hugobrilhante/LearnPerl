#!/usr/bin/env perl
use lib qw(lib);
use Dancer2;
use Bank;

my $bank = Bank->new('account.csv', 'transactions.csv');

get '/account/:account_number' => sub {
    my $account_number = route_parameters->get('account_number');
    my $account = $bank->get_account($account_number);

    if ($account) {
        return to_json({
            account_number => $account->{account_number},
            balance => $account->{balance}
        });
    } else {
        status 404;
        return to_json({ error => "Account not found" });
    }
};

get '/balances' => sub {
    $bank->calculate_balances();

    my $balances = [];
    for my $account (values %{$bank->{accounts}}) {
        push @{$balances}, {
            account_number => $account->{account_number},
            balance => $account->{balance}
        };
    }

    return to_json($balances);
};

dance();
