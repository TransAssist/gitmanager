#!/usr/bin/env perl
##!/bin/perl


##
use utf8;
use strict;
use warnings;
##
use Cwd;
use FindBin;
use File::Basename;

##main
#print "HelloWorld\n";

##os
my $br;
my $sl;
my $os="$^O\n";
if ($os eq "MSWin32"){
  #windows:MSWin32i
  binmode STDIN, ':encoding(cp932)';
  binmode STDOUT, ':encoding(cp932)';
  binmode STDERR, ':encoding(cp932)';
  $br = "¥n";
  $sl = "\\";
}else{
  #linux:linux
  #osx:freebsd
  $br = "\n";
  $sl = "/";
}

##path
my $bin = $sl."wer";
my $wd = Cwd::getcwd();
my $bin_path = ($FindBin::Bin).$bin;
#print "bin:".$bin_path."\n";
my $bin_dir;
if (-l $bin_path) {#symbolic check
	#print "true";
    $bin_path = readlink($bin_path);
}
#get parent bin path
$bin_dir = dirname($bin_path).$sl;
#print "bin_path:".$bin_path."\n";
#print "bin_dir:".$bin_dir."\n";


##args
my ($cmd, $param);
if (@ARGV == 0){
  &hello("wer");
  print &date()." ".&time().$br;
  &testbash();
}elsif (@ARGV == 1 or @ARGV == 2){
  my $cmd = $ARGV[0];
  if (@ARGV == 1){
    print "simple command:$cmd$br";
  }else{
    my $param = $ARGV[1];
    print "A=$cmd,B=$param$br";
  }
}else{
  print "unknown cmd pattern$br";
  exit(0);
}




##subroutine,function
#&hello("wer");
sub hello {
	(my $str) = @_;
	print "hello,$str!$br";
}
sub date {
  my @week = ('Sun', 'Mon', 'Thu', 'Wed', 'Thu', 'Fri', 'Sat');
  (my $mday,my $mon,my $year,my $wday) = (localtime(time))[3..6];
  $year += 1900;
  $mon += 1;
  return "$year/$mon/$mday($week[$wday])";
}
sub time{
  (my $sec,my $min,my $hour) = (localtime(time))[0..2];
  return "$hour:$min:$sec";
}
sub exec {
  (my $command) = @_;
  my $result = `$command 2>&1`;
  return $result;
}
sub testbash {
  my $res = &exec($bin_dir."tool/test.sh"); 
  print "testbash:".$res;
}



