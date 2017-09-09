#!/usr/bin/env perl

use strict;
use warnings;

my @week = ('Sun', 'Mon', 'Thu', 'Wed', 'Thu', 'Fri', 'Stu');
(my $sec,my $min,my $hour,my $mday,my $mon,my $year,my $wday,my $yday,my $isdst) = localtime(time);
$year += 1900;
$mon += 1;
my $timestamp = "$year/$mon/$mday($week[$wday]) $hour:$min:$sec";
print "example:".$timestamp."\n";

