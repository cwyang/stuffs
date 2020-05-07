#!/usr/bin/env perl
# bot
# 7 May 2020
# Chul-Woong Yang
use strict;
use warnings;
use v5.10;
use DateTime;
use WWW::Telegram::BotAPI;

our $chat_id="";
our $telegram_token='';
require './token.pl';	# override $chat_id, $telegram_token

my $api = WWW::Telegram::BotAPI->new (
    token => "$telegram_token"
);
sub send_message {
    my $msg = shift;
    $api->sendMessage ({
	chat_id => $chat_id,
	text => $msg
    });
}

my $debug = 0;
my $dryrun = 0;
my $master_res = "res";
my $temp_res = "temp.res";
my $sleep = 60;

sub run_cmd {
    my $cmd = shift;
    print "$cmd\n" if ($debug);
    return if ($dryrun);
    my $result = system("$cmd");
    if ($result != 0) {
	print "  Error: ($result) $cmd \n";
    }
}

send_message("loop starts at " . DateTime->now);

for (;;) {
    #run_cmd("./check.sh > $temp_res");
    #my $diff_res = `diff $master_res  $temp_res`;
    my $diff_res = `diff $master_res  $temp_res`;
    if ($?) {
	send_message "$diff_res";
	run_cmd("mv $temp_res $master_res");
	$sleep += 60;
    }

    sleep ($sleep);
}

