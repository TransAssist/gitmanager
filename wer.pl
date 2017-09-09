#!/usr/bin/env perl
##!/bin/perl

#
use utf8;
use strict;
use warnings;
#
use Cwd;
use FindBin;
use File::Basename;

#main
#print "HelloWorld\n";

#os check
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

#currentdirectory
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

##exec
#print $bin_dir."date.sh\n";
my $command = $bin_dir.'/date.sh';
my $result = `$command 2>&1`;
print $result;


#args
my ($kokugo, $sansuu);
if (@ARGV == 2){
  my $kokugo = $ARGV[0];
  my $sansuu = $ARGV[1];
  print "A=$kokugo,B=$sansuu\n";
  if ($kokugo > 75 && $sansuu > 75){
    print "ok\n";
  }else{
    print "false\n";
  }
}else{
  print "require args 2\n";
}


#($mday,$mon,$year) = (localtime(time))[3..5];
#$year += 1900;
#$mon += 1;

#my $timestamp = "$year/$mon/$mday";
#print $timestamp;


