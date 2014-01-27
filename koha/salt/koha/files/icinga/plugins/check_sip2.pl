#!/usr/bin/perl
#------------------------------------------------------------------
# SIP2 Server Check. 
# Verifies status of SIP2 Server based on return string of a 
# patron information request
# Author: Barry Cannon 
# Date: 05/11/2013
# Rev 1.01 - 07/11/2013 - added socket timeout
#------------------------------------------------------------------

use strict;
use warnings;
use Data::Dumper;
use Getopt::Long;

my %opts;
my %fields;
my @response;

GetOptions (\%opts,
'server|s=s', 
'port|p=i',
'borrower|b=s',
'pin=s',
'location|l=s',
'use_sip_auth|usa',
'sip_user|sau=s',
'sip_pass|sap=s',
'ecc=s',
'arnold|t2=s',
'field_ident|fi=s',
'help|h'
) 
or die("CRITICAL: Error detected in arugments. Please see usage for help.\n");

if (not keys %opts ) {  
  usage();
  exit (2)
}

if ($opts{help} ) {
  show_help();
  exit (2);
}
unless ( $opts{server} && $opts{port} && $opts{borrower} ) {
  print "CRITICAL: required fields are '--server --port --borrower ' \n";
  exit (2);
}

if ( $opts{use_sip_auth}  ) {
  unless ( $opts{sip_user} && $opts{sip_pass} ) {
    print "CRITIAL: You must specifiy a SIP user and SIP password if SIP authentication is enabled\n";
    exit (2)
  }
}

if ( $opts{pin} ) {
  $opts{sip_use_pin} =1 
}

foreach (keys %opts) {
  chomp $opts{$_} 
  }

my $config = {
    sip_server    =>  $opts{server},
    sip_port    =>  $opts{port},
    sip_auth_login  =>  $opts{use_sip_auth} || 0,
    sip_user    =>  $opts{sip_user},
    sip_pass    =>  $opts{sip_pass},
    sip_use_pin   =>  $opts{sip_use_pin} || 0,
    sip_location  =>  $opts{location} || '',
    field_ident   =>  $opts{field_ident} || '|',
    send_char   =>  chr(0x0d),    
  };

my $sip = SIP->new($config);
my $result = $sip->go($opts{borrower},$opts{pin});

if (ref $result eq 'HASH' ) {
  print "CRITICAL: SIP login failed\n";
  exit (2); 
}

@response = split /\Q$config->{field_ident}\E/ , $result;
  foreach (@response) {
    my $id = substr $_,0,2;
    my $value = substr $_,2;
    $fields{$id} = $value;
  }

if ( $fields{98} && substr ($fields{98},0,1) eq 'N' ) {
  print "CRITICAL: SIP Server not online. Maybe you need to use SIP authentication?\n";
  exit (2);
}

if ( $fields{BL} eq 'N' ) {
  print "CRITICAL: SIP Check for Borrower: $opts{borrower} returning invalid.\n";
  exit (2);
}

elsif ( $fields{BL} eq 'Y' ) {
  print "OK: SIP Server online for borrower: '$fields{AE}'\n"
}


sub usage {
print "Usage:\n";
print "check_sip2.pl -s HOST -p port -b borrowernumber [-p <pin>] [-l <location>]\n";
print "[-usa <use sip auth>] [-sau <SIP user>] [-sap <SIP password>] [-arnold <Terminator>]\n";
print "[-fi <field indentifier>]\n";
}

sub show_help {
print "SIP2 Self Check Nagios plugin.\n";
print "This Plugin connects to a remote SIP2 server and sends a Patron Information request.\n";
print "It parses the result and checks the patron is valid (BL field). If valid the SIP server\n";
print "is thought to be active.\n\n";
print "Required fields are <host>, <port> and <borrowernumber>. Optional arguments can be passed\n";
print "for servers requiring SIP authenticaiton prior to the patron information request.\n";
print "As per the specification you can also provide optionial <location>, <terminator> and\n";
print "<field_indentifier>.\n";
print "Although the <pin> is there SIP will still return a response indicating if the borrower is\n";
print "valid. In reality, there is no need to ever send a PIN but it exists to adhere to the spec\n";   

print "\n";
usage();

}

package SIP;

use IO::Socket;
use POSIX qw(strftime);

sub new {
  my $class = shift;
  my $self = shift;
  unless (ref $self eq 'HASH' ) {
    print "Config HASH ref required\n";
      return 3; 
    }
  bless $self, $class;
  $self->init;
  return $self;
}

sub init {
    my ($self) = @_;
    if ($self->{sip_auth_login}) {
    $self->make93
    }
  else {
     $self->make99 
  }

    return;
}

sub go {
  my $self = shift;
  my $userid = shift;
  my $pin    = shift;
  my $socket = IO::Socket::INET->new(PeerAddr => $self->{sip_server},
      PeerPort => $self->{sip_port},
      Proto    => 'tcp',
      Type     => SOCK_STREAM,
      Timeout  => '15')
      or die "CRITICAL: Cannot connect to SIP Server address: $self->{sip_server}\n";
  
  if ( $self->{str_99} ) {
    my $response = $self->talk99($socket,$userid,$pin);
    return $response;
  }
  elsif ( $self->{str_93} ) { 
    my $response = $self->talk93($socket,$userid,$pin);
    return $response;
    }
  
  
}

sub talk93 {
  my ($self,$socket,$userid,$pin) = @_;
  my $send93 = $self->{str_93};
  $send93 .= $self->{send_char};
  $socket->send($send93);
  my $response;
    $socket->recv($response, 1024);
    chomp $response;
  my $auth = substr $response,2,1;
  my $run_num = substr $response, 5,1;
  
  if ( $auth == "1" ) {
    my $str99 = $self->make99($run_num);
    my $sip_resp = $self->talk99($socket,$userid,$pin);
  return $sip_resp;
  }
  elsif ($auth == "0") {
    return {error => "Invalid SIP server login credentials"} 
  }
}

sub talk99 {
  my ($self,$socket,$userid,$pin) = @_;
  my $send99 = $self->{str_99};
  $send99 .= $self->{send_char};
  $socket->send($send99);
  my $response;
    $socket->recv($response, 1024);
    chomp $response;
  if ( (substr $response, 0,3) eq '98Y') {
    #my ($chk, $end) = split (/(\|AY)/ ,$response); # why isn't this preserving my delimiter!?
    my ($chk, $end) = split /\|AY/ ,$response;
    $chk .= "|AY";
    my $run_num = substr($end,0,1);
    my $sip_response = $self->talk63($userid,$pin,$run_num,$socket) . $self->{send_char};
    $socket->send($sip_response);
    $socket->recv($response, 1024);
    $socket->close();
    return $response;
    } 
}

sub talk63 {
  my ($self,$userid,$pin,$run_num,$socket) = @_;
  my $summary = "          ";
  my $str = "63" . "001" . timestamp() . $summary;
  $str .= "AO" . $self->{sip_location} . $self->{field_ident} . "AA$userid" . $self->{field_ident} . "AC" . $self->{field_ident};
    if ( $self->{sip_use_pin} ) {
      $str .= "AD" . $pin . $self->{field_ident}
    }
  my $response = checksum($str,$run_num);
  return ($str . $response)
  
}

sub make99 {
  my $self = shift;
  my $run_num = shift;
  # Sticking with fixed status code and width. SIP 2.00 only.
  my $string = "9900302.00";
  my $final = checksum($string,$run_num);
  $self->{str_99} = $string . $final;
  
}

sub make93 {
  my $self    = shift;
  # Assuming no support for encrypted UID/PWD
  my $string    =   "9300";
  $string .= "CN" . $self->{sip_user} . $self->{field_ident};
  $string .= "CO" . $self->{sip_pass} . $self->{field_ident};
  $string .= "CP";
    if( $self->{sip_location} ) { 
      $string .= $self->{sip_location} . $self->{field_ident};
    }
    else {
      $string .= " " . $self->{field_ident}; 
    }
    my $str_93 = checksum($string);
  $self->{str_93} = $string . $str_93;

}

sub checksum {
  my $str = shift;
  my $run_num = shift;
   if (defined $run_num == 10) {
        $run_num = 0;
    }
    unless ($run_num) {$run_num = '0'}
    $run_num++;
  my $trail = "AY$run_num" . 'AZ';     
    $str .= $trail;
    my $checksum = -unpack('%16U*', $str) & 0xFFFF;
    $trail .= sprintf '%04.4X', $checksum;
    
    return $trail;
    
}
 sub timestamp {
    my $timestamp = strftime '%Y%m%d    %H%M%S', localtime;
    return $timestamp;
}


sub parse_64 {
  my $str = shift;
  my %results;
  my @str = split /\|/,$str;
    foreach my $res (@str) {
      my $code = substr $res,0,2 ;
        $results{$code} = substr $res,2;
    }
  return \%results;
}

1;
