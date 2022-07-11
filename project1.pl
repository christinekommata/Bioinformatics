$/="\/\/\n"; 
#I can extract number AA from ID and SQ; keep that in mind
while (<>)
{

#first line
	if ($_=~/^ID\s{3}(.*?)\s+(.*?)\;\s+(\d+\sAA.)/m)
	{
		#print ">$1|$3";
		print ">$1";
	}
	if ($_=~/^AC\s{3}(.*?)\;/m)
	{
		print "|$1";
	}
	if ($_=~/^SQ   SEQUENCE\s+(.*?)\;/m)
	{
		print "|$1\n";
	}

#second line
	while ($_=~/^\s{5}(.*)/mg)
	{
		$sequence=$1;
		$sequence=~s/\s//g;
#keeping sequence's length of each record
                $seq_length = length($sequence);
                $seq_length = @sequence;
                push @sequence, sequence;
		print "$sequence";
	}
	print "\n";



#third line (with array)

	if ($_=~/^FT\s{3}TRANSMEM\s+(\d+)\s+(\d+)\s+(.*)\./m)
	{
		@tmstart=$1; #antisoixei sthn proth paren8esh
		@tmend=$2; #antisoixei sthn 2h paren8esh
        }

        for ($a=0;$a<=seq_length;$a=$a+1)
        {
	    pop @sequence;
            if (($a>=$1) && ($a<=$2))
	    {   @sequence[$a] = "M";
		print @sequence[$a];
            }
            else
            {   @sequence[$a] = "-";
                print @sequence[$a];
            }
        }
         
        

	print "\n";
        print "//";
        print "\n";


}