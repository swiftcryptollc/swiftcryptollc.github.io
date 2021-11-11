#/usr/bin/perl

my ($logDir, $toEmail) = @ARGV;

if ((not defined $logDir) ||
   (not defined $toEmail)) {
  usage();
}

my $hostname=`hostname -s`;
chomp($hostname);
my $fromEmail="${hostname}\@${hostname}.com";
my $FILE=`find ${logDir} -type f -mmin -1`;
open($FILE_READER, "<$FILE") or die "Can't open log";
my $mainGPUCtr = 4320;
my $sendSummary = 4320;
my %gpuTotalMHs = ();
my %gpuMHs = ();
my %totalCount = ();
my $invalidGPUHash = 0;
my $sendMail = 0;
my $uptime = `uptime`;
my $ctr = 0;
my $totalMHs= 0;
`rm -f /tmp/pmmail*`;
open($MAIL, ">/tmp/pmmail${ctr}.tmp") or die "Can't open mail file!";
print $MAIL "From: ${fromEmail}\n";
print $MAIL "Subject: Phoenix Reboot Occured\n\n";
print $MAIL "System just came up after a reboot\n";
print $MAIL "\n\n";
print $MAIL ".\n";
close MAIL;
system("sudo sendmail '${toEmail}' < /tmp/pmmail${ctr}.tmp &");
$ctr++;

while(1) {
    if(eof $FILE_READER) {
        sleep 50;
        $sendMail = 1;
        $FILE_READER->clearerr;
        next;
    }
    my $line = <$FILE_READER>;
    chomp($line);
    if($line =~ /Incorrect ETH share from/) {
	open($MAIL, ">/tmp/pmmail${ctr}.tmp") or die "Can't open mail file!";
        print $MAIL "From: ${fromEmail}\n";
        print $MAIL "Subject: Phoenix Incorrect ETH share\n\n";
        print $MAIL $line;
        print $MAIL "\n\n";
        print $MAIL ".\n";
        close MAIL;
        if ($sendMail == 1) {
            system("sudo sendmail '${toEmail}' < /tmp/pmmail${ctr}.tmp &");
            $ctr++;
        }
    } elsif($line =~ /main GPUs: 1:/) {
        #  Produced every 5 seconds
        $mainGPUCtr += 1;
        my @matches = ( $line =~ /(\d+: \d+\.\d{3}) MH\/s/g );
        for (@matches) {
            my @splitGPU = split(': ', $_);
            if (%gpuTotalMHs) {
                $gpuTotalMHs{$splitGPU[0]} += $splitGPU[1];
            } else {
                $gpuTotalMHs{$splitGPU[0]} = $splitGPU[1];
            }
       
            if ((%gpuMHs) && ($gpuMHs{$splitGPU[0]} > 0)) {
                $diff = $splitGPU[1] - $gpuMHs{$splitGPU[0]};
                $percentDiff = $diff / $gpuMHs{$splitGPU[0]};
                if ($percentDiff > 1) {
                    if ($invalidGPUHash == 0) {
	                open($MAIL, ">/tmp/pmmail${ctr}.tmp") or die "Can't open mail file!";
                        print $MAIL "From: ${fromEmail}\n";
                        print $MAIL "Subject: Phoenix Invalid GPU $splitGPU[0] Hash\n\n";
                        print $MAIL $line;
                        print $MAIL "\n\n";
                        print $MAIL "Restarting\n\n";
                        print $MAIL ".\n";
                        close MAIL;
                        if ($sendMail == 1) {
                            system("sudo sendmail '${toEmail}' < /tmp/pmmail${ctr}.tmp");
                            $ctr++;
                        }
                        system("(sleep 1;sudo pkill PhoenixMiner;sudo pkill xmrig;sudo reboot) &");
                    }
                    if (++$invalidGPUHash > 360) {
                        $invalidGPUHash = 0;
                    }
                }
            }
            if ($gpuTotalMHs{$splitGPU[0]} > 0) {
                if ($totalCount{$splitGPU[0]}) {
                    if ($splitGPU[1] > 0) {
                        $totalCount{$splitGPU[0]} += 1;
                    }
                } else {
                    $totalCount{$splitGPU[0]} = 1;
                }
                $gpuMHs{$splitGPU[0]} = sprintf("%.3f", $gpuTotalMHs{$splitGPU[0]}/$totalCount{$splitGPU[0]});
            }
        }
        if (($mainGPUCtr >= $sendSummary) && ($sendMail == 1)) {
            $mainGPUCtr = 0;
            $uptime = `uptime`;
            chomp($uptime);
	    open($MAIL, ">/tmp/pmmail${ctr}.tmp") or die "Can't open mail file!";
            print $MAIL "From: ${fromEmail}\n";
            print $MAIL "Subject: Phoenix Hash Update\n\n";
            print $MAIL $line;
            print $MAIL "\n\nAverage:\n";
            $size = keys %gpuMHs;
            $totalMHs = 0;
            for ($i = 1; $i <= $size; $i++) {
                print $MAIL "$i";
                print $MAIL ": ";
                print $MAIL "$gpuMHs{$i}";
                print $MAIL " MH/s";
                print $MAIL "\n";
                $totalMHs += $gpuMHs{$i};
            }
            print $MAIL "\nAvg MHs: ";
            print $MAIL $totalMHs;
            print $MAIL "\n\nUptime: ";
            print $MAIL $uptime;
            print $MAIL "\n";
            print $MAIL ".\n";
            close MAIL;
            system("sudo sendmail '${toEmail}' < /tmp/pmmail${ctr}.tmp &");
            $ctr++;
        }
    }
}

sub usage {
  print "\nUsage: perl phoenix-watch.pl <log directory> <to email>\n";
  print "    <log directory>: replace with the location of your log files. Ex: /opt/phoenix/logs\n";
  print "    <to email>: replace with the email that you want to send updates to\n\n";
  exit(-1);
}

