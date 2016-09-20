package Test_Whitelists;

use strict;
use Test::More;

our $tests = 4;

sub run_tests {
    my ($client) = @_;

    {
        my $reply = $client->request({
            client_name    => 'mail-xn1nam02ob0613.outbound.protection.outlook.com',
            client_address => '2a01:222:f400:fe44::613',
            sender         => 'test@example.com',
            recipient      => 'test@example.org',
        });
        ok(defined $reply, 'send request');
        is($reply, 'DUNNO', "whitelisted: outlook.com");
    }

    # Verify whitelist entry: 195.235.39
    {
        my $reply = $client->request({
            client_name    => 'blabla.example.com',
            client_address => '195.235.39.10',
            sender         => 'test@example.com',
            recipient      => 'test@example.org',
        });
        ok(defined $reply, 'send request');
        is($reply, 'DUNNO', "whitelisted: 195.235.39.10");
    }
}

1;
