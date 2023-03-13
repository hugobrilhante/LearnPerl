#!/usr/bin/perl
use warnings;
use strict;
use lib qw(lib);

use Bank;

my $bank = Bank->new('account.csv', 'transactions.csv');

$bank->calculate_balances();
$bank->get_balances();



