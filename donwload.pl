#!/usr/bin/env perl
use File::Fetch;
my $url = 'http://x-as.com/TransAssist.gif';
my $ff = File::Fetch->new(uri => $url);
my $file = $ff->fetch() or die $ff->error;

