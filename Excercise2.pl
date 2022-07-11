#!/usr/bin/perl
%hyd =('A' => 0.100, 
      'C' => -1.420,
      'D' => 0.780,
      'E' => 0.830,
      'F' => -2.120,
      'G' => 0.330,
      'H' => -0.500,
      'I' => -1.130,
      'K' => 1.400,
      'L' => -1.180,
      'M' => -1.590,
      'N' => 0.480,
      'P' => 0.730,
      'Q' => 0.950,
      'R' => 1.910,
      'S' => 0.520,
      'T' => 0.070,
      'V' => -1.270,
      'W' => -0.510,
      'Y' => -0.210
      ); # Παίρνουμε της τιμές απο το http://www.compgen.org/material/courses/bioinformatics2/transmembrane-proteins.

open(TP1, "transmem_proteins.swiss") or die "could not open file";#Ανοίγουμε το αρχείο transmem_proteins.swiss.
open(OUT, ">OUTPUT$ARGV[1].txt") or die "could not open out";#Ανοίγουμε το OUTPUT.

$seq = ""; # Ορίζουμε Ακολουθία
while(<TP1>)
{
    if($_ =~ /^FT   TRANSMEM\s+(\d+)\s+(\d+)/mg)#Αναγνώριση της αρχής και τέλους διαμεμβρανικού τμήματος .
    {
        push @starts, $1;
        push @ends, $2;
    }
    ################################################
    if ($_ =~ /^     (.*)/mg)#Τοποθετεί όλες της ακολουθίες σε μια γραμμή
    {
        $line = $1;        
        $line =~ s/\s//g; #Αφαιρώ το μεταξύ τους κενό.   
        $seq = $seq . $line;
    }
    #################################################
}

close TP1 or die "file did not close properly";#Κλείσιμο while.

@sseq = split '', $seq; #Παίρνουμε την λίστα των χαρακτήρων.
###############################################################################
$window_length = $ARGV[0];#Ορίζουμε το μέγεθος του παραθύρου
$center = int($window_length / 2);

$len = scalar @sseq;



for($i = $center; $i < $len - $center; $i++)
{
    $s = $hyd{$sseq[$i]};
    for($j = 1; $j < $center; $j++)
    {
        $s = $s + $hyd{$sseq[$i - $j]} + $hyd{$sseq[$i + $j]}
    }

    $h = $s / $window_length;

    if($h > 0.000000001)
    {
        push @tm, 1;
    }
    else
    {
        push @tm, 0;
    }

}
##############################################################################
##Τυπώσεις σύμφωνα με την εκφώνηση.
print OUT @sseq;
print OUT "\n";
for($i=0; $i < $center; $i++)
{
    print OUT " ";
}
print OUT @tm;
print OUT "\n";
print OUT join ' ', @starts;
print OUT "\n";
print OUT join ' ', @ends;
print OUT "\n";
###############################################################################
#Υπολογίζουμε true positives, true negatives, false positives και false negatives.
$tp, $tn, $fp, $fn = (0, 0, 0, 0);

for($i = 0; $i < scalar @tm; $i++)
{
    $idx = $i + $center + 1;
    $s1 = 0;
    $s2 = 0;
    for($j = 0; $j < scalar @starts; $j++)
    {
        $start = $starts[$j];
        $end = $ends[$j];

        #Υπολογίζουμε true positive
        if($tm[$i] and $idx >= $start and $idx <= $end)
        {
            $tp += 1;
        }
        #Υπολογίζουμε false negative
        elsif((not $tm[$i]) and $idx >= $start and $idx <= $end)
        {
            $fn += 1;
        }
        #Υπολογίζουμε false positive
        elsif($tm[$i])
        {
            $s1 += 1;
        }
        #Υπολογίζουμε true negative
        elsif(not $tm[$i])
        {
            $s2 += 1;
        }
    }
    if($s1 == scalar @starts)
    {
        $fp += 1;
    }
    elsif($s2 == scalar @starts)
    {
        $tn += 1;
    }
}
##################################################################################################
$accuracy = ($tp + $tn) / ($tp + $fp + $tn + $fn);#Υπολογίζουμε το Accuracy.
print OUT "Accuracy: $accuracy\n";
##################################################################################################
$MCC = ($tp * $tn - $fp * $fn) / sqrt (($tp + $fp) * ($tp + $fn) * ($tn + $fp) * ($tn + $fn));#Υπολογίζουμε MCC.
print OUT "MCC: $MCC\n";

