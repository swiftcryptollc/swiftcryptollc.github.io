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
my $mainGPUCtr = 720;
my $sendSummary = 720;
my %gpuTotalMHs = ();
my %gpuTotalLHRs = ();
my %gpuShares = ();
my %gpuMHs = ();
my %gpuLHRs = ();
my %totalCount = ();
my %totalLHREvents = ();
my %totalLHRCount = ();
my $invalidGPUHash = 0;
my $sendMail = 0;
my $uptime = `uptime`;
my $ctr = 0;
my $totalMHs= 0;
`rm -f /tmp/twatchmail*`;
open($MAIL, ">/tmp/twatchmail${ctr}.tmp") or die "Can't open mail file!";
print $MAIL "From: ${fromEmail}\n";
print $MAIL "Subject: T-Rex Reboot Occured\n\n";
print $MAIL "System just came up after a reboot\n";
print $MAIL "\n\n";
print $MAIL ".\n";
close MAIL;
system("sudo sendmail '${toEmail}' < /tmp/twatchmail${ctr}.tmp &");
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
    $line =~ s/\e\[[0-9;]*m//g;
    if($line =~ /^GPU #\d+/) {
        #  Produced every 30 seconds
        my @hashRates = ($line =~ /[0-9]+.[0-9]+ MH\/s/g);
        my @gpuNums = ($line =~ /#[0-9]+/g);
        my @shares = ($line =~ /[0-9]+\/[0-9]+/g);

        my @gpuNum = ($gpuNums[0] =~ /[0-9]+/g);
        my @hashRate = ($hashRates[0] =~ /[0-9]+.[0-9]+/g);
        
        $gpuShares{$gpuNum[0]} = $shares[0];

        if (%gpuTotalMHs) {
            $gpuTotalMHs{$gpuNum[0]} += $hashRate[0];
        } else {
            $gpuTotalMHs{$gpuNum[0]} = $hashRate[0];
        }
        if ($gpuTotalMHs{$gpuNum[0]} > 0) {
            if ($totalCount{$gpuNum[0]}) {
                if ($hashRate[0] > 0) {
                    $totalCount{$gpuNum[0]} += 1;
                }
            } else {
                $totalCount{$gpuNum[0]} = 1;
            }
            $gpuMHs{$gpuNum[0]} = sprintf("%.3f", $gpuTotalMHs{$gpuNum[0]}/$totalCount{$gpuNum[0]});
        }
        if($line =~ /LHR/) {
            my @lhrs = ($line =~ /LHR [0-9]+/g);
            my @lhr = ($lhrs[0] =~ /[0-9]+/g);
            if (%gpuTotalLHRs) {
                $gpuTotalLHRs{$gpuNum[0]} += $lhr[0];
            } else {
                $gpuTotalLHRs{$gpuNum[0]} = $lhr[0];
            }

            if ($gpuTotalLHRs{$gpuNum[0]} > 0) {
                if ($totalCount{$gpuNum[0]}) {
                    if ($lhr[0] > 0) {
                        $totalLHRCount{$gpuNum[0]} += 1;
                    }
                } else {
                    $totalLHRCount{$gpuNum[0]} = 1;
                }
                $gpuLHRs{$gpuNum[0]} = sprintf("%.3f", $gpuTotalLHRs{$gpuNum[0]}/$totalLHRCount{$gpuNum[0]});
            }
        }
    } elsif($line =~ /^Hashrate/) {
        #  Produced every 30 seconds
        $mainGPUCtr += 1;
        if (($mainGPUCtr >= $sendSummary) && ($sendMail == 1)) {
            $mainGPUCtr = 0;
            $uptime = `uptime`;
            chomp($uptime);
            open($MAIL, ">/tmp/twatchmail${ctr}.tmp") or die "Can't open mail file!";
            print $MAIL "From: ${fromEmail}\n";
            print $MAIL "Subject: T-Rex Hash Update\n\n";
            print $MAIL $line;
            print $MAIL "\n\nHash Average:\n";
            $totalMHs = 0;
            foreach my $key(sort(keys %gpuLHRs)) {
                print $MAIL "$key";
                print $MAIL ": ";
                print $MAIL "$gpuMHs{$key}";
                print $MAIL " MH/s (";
                print $MAIL "$gpuShares{$key}";
                print $MAIL ")\n";
                $totalMHs += $gpuMHs{$key};
            }
            print $MAIL "\nAvg MHs: ";
            print $MAIL $totalMHs;
            print $MAIL "\n\nLHR Average:\n";
            foreach my $key(sort(keys %gpuLHRs)) {
                print $MAIL "$key";
                print $MAIL ": ";
                print $MAIL "$gpuLHRs{$key}";
                print $MAIL "\n";
            }
            print $MAIL "\nLHR Deadlocks:\n";
            foreach my $key(sort(keys %gpuLHRs)) {
                print $MAIL "$key";
                print $MAIL ": ";
                print $MAIL "$totalLHREvents{$key}";
                print $MAIL "\n";
            }
            print $MAIL "\nUptime: ";
            print $MAIL $uptime;
            print $MAIL "\n";
            print $MAIL ".\n";
            close MAIL;
            system("sudo sendmail '${toEmail}' < /tmp/twatchmail${ctr}.tmp &");
            $ctr++;
        }
    } elsif($line =~ /LHR detected/) {
        my @gpus = ($line =~ /[0-9]+: LHR detected/g);
        my @gpuNum = ($gpus[0] =~ /[0-9]+/g);

        if (%totalLHREvents) {
            $totalLHREvents{$gpuNum[0]}++;
        } else {
            $totalLHREvents{$gpuNum[0]} = 1;
        }
    }
}

sub usage {
  print "\nUsage: perl trex-watch.pl <log directory> <to email>\n";
  print "    <log directory>: replace with the location of your log files. Ex: /opt/trex/logs\n";
  print "    <to email>: replace with the email that you want to send updates to\n\n";
  exit(-1);
}
