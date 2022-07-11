#!/usr/bin/perl
open (TP,$ARGV[0]) or die ("Could not open TP");	#Περνάμε σαν όρισμα στο πρόγραμμα transmembrane_proteins.swiss).
open (out, ">OUTPUT.txt");	#Ανοίγουμε το OUTPUT.

while (<TP>)
{	
	if($_=~m/^ID   (\S{0,10})/)	#Αναγνώριση του ID.
	{
		$id = $1;
	}	
	######################################################
	if ($_=~m/^AC   (\S+)\;/)	#Αναγνώριση του AC.
	{
		push(@ac,$1);
	}
	######################################################
	if ($_=~m/^FT   (\S+) +(\d+) +(\d+)/)	#Αναγνώριση του διαμεμβρανικού τμήματος.
	{
		for ($i=$2-1; $i<$3; $i++)
		{
			if ($1 eq "TRANSMEM")
			{
				$ss[$i]="M";
			}
		}
	}
	#######################################################
	if ($_=~m/^SQ   (\S{8})   (\d+)/)	#Αναγνώριση του μήκους σε αμινοξέα.
	{
		$length = "$2aa";
	}
	#######################################################
	if ($_=~m/^ {5}(.+)\n/)	#Αναγνώριση της η αμινοξική ακολουθία της πρωτεΐνης και η αποθήκευσή της σε μία μεταβλητή τύπου String χωρίς κενά.
	{
		$seq.=$1;
		$seq=~s/ //g;
	}
	#######################################################
	if ($_=~m/^\/\/\n/)	#Έλεγχος για τον διαχωρισμό των πολλαπλών καταχωρήσεων.
	{
		for ($i=0; $i<length($seq); $i++)	#Βρόγχος που θέτει στις θέσεις, που δεν υπάρχει διαμεμβρανικό τμήμα, την '-'.
		{
			if ($ss[$i] eq "")
			{
				$ss[$i]='-';
			}
	}
    ########################################################
		$ss=join("",@ss);	#Δημιουργία της 3ης γραμμής.

		#Τυπώσεις σύμφωνα με την εκφώνηση.
		print out ">$id|$ac[0]|$length\n";
		print out "$seq\n$ss\n";
		print out "//\n";
		
		$seq='';
		$id='';
		@ss=();
		@ac=();
	
	}
}