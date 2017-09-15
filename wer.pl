#!/usr/bin/env perl
##!/bin/perl


##
use utf8;
use strict;
use warnings;
use open ":utf8";
##
use Cwd;
use FindBin;
use File::Fetch;
use File::Basename;
use JSON;

##main
#print "HelloWorld\n";

##os
my $br;
my $sl;
#my $processnumberstring = "$$";
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

##set default
my $default_shebang="#!/usr/bin/env ";
##cache
my $tmp_dir=$sl."tmp".$sl;
my $tmp_flg=$tmp_dir."ok";
my $cache=$bin_dir."cache".$sl;
my $cache_status=$bin_dir."profile".$sl."status.json";
my $cache_werc=$bin_dir."profile".$sl."werc";

##args
my ($cmd, $param);
my $wer_help = <<'EOS';
wer help/hello/check/init/run
wer status load/write
wer werc load/write
wer save [url]
.bashrc:+`perl $LOCAL_BIN/wer run`
EOS
if (@ARGV == 0){
  print &date()." ".&time().$br;
  print "---config---".$br;
  print "default_shebang:".$default_shebang."[cmd]$br";
  &test("bash","tool/test.sh");
  &test("perl","tool/test.pl");
  print "tmp_dir:".$tmp_dir.$br;
  print "tmp_flg:".$tmp_flg.$br;
  print "cache:".$cache.$br;
  print "cache_status:".$cache_status.$br;
  print "cache_werc:".$cache_werc.$br;
}elsif ( @ARGV == 1 or @ARGV == 2 or @ARGV == 3 ){
  my $p1 = $ARGV[0],my $p2 = $ARGV[1],my $p3 = $ARGV[2];
  if (@ARGV == 1){
    print "p1=$p1 $br";
    if ($p1 eq "help"){
      print "$wer_help";
    }elsif($p1 eq "hello"){
      &hello("wer");
    }elsif($p1 eq "init"){
      &init();
    }elsif($p1 eq "check"){
      &check();
    }elsif($p1 eq "run"){
      &run();
	}else{
      print "unknown simple param:$p1".$br;
	}
  }elsif(@ARGV == 2){
    print "p1=$p1,p2=$p2".$br;
    if ($p1 eq "save"){
      &save($p2);
    }elsif ($p1 eq "status"){
      ##for status.json
      if($p2 eq "load"){
        &status_load();
      }elsif($p2 eq "write"){
        &status_write();
      }
    }elsif($p1 eq "werc"){
      ##for werc
      if($p2 eq "load"){
        &werc_load();
      }elsif($p2 eq "write"){
        &werc_write();
      }
    }
  }elsif(@ARGV == 3){
    print "p1=$p1,p2=$p2,p3=$p3".$br;
  }
  exit(0);
}else{
  print "unknown param pattern$br";
  exit(0);
}


##subroutine,function
#&hello("wer");
sub hello {
	(my $str) = @_;
	print "hello,".$str."!".$br;
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
sub test {
  (my $name,my $cmdpath) = @_;
  my $res = &exec($bin_dir.$cmdpath);
  my $result = $res eq "complete" ? "ok" : "ng";
  print "test_".$name." : ".$res." ==> [".$result."]".$br;
}
sub init{
  my $file = $tmp_dir."ok";
  if (-e $file) {
    die "$file already exists";
  }else {
    open my $fh, ">", $file
      or die "$file erro : $!";
    close $fh;
  }
}
sub check{
  if (-e $tmp_flg) {
    print "already exists".$br;
  }else {
    print "not found".$br;
  }
}
sub status_load{
  print "load:".$cache_status.$br;
  open(DATAFILE, "< ".$cache_status) or die("Error:$!");
  while(my $line = <DATAFILE>){
    chomp($line);
    print "$line".$br;
  }
}
sub status_write{
  print "status write".$br;
}
sub werc_load{
  print "werc load".$br;
}
sub werc_write{
  print "werc write".$br;
}
sub save{
  (my $url) = @_;
#  my $url = "http://x-as.com/TransAssist.gif";
  print "save:$url".$br;
  my $ff = File::Fetch->new(uri => $url);
  my $file = $ff->fetch() or die $ff->error;
}
sub run{
  print "run".$br;
}
