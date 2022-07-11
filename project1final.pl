#Project1 code: Bioinformatics II 2020-2021

$/="\/\/\n"; 

#I can extract number AA from ID and SQ; keep that in mind

while (<>)
{

#First Line: ID, AC and sequence's length of each record

	if($_=~/^ID\s{3}(.*?)\s+(.*?)\;\s+(\d+\sAA.)/m)
	{
		#print ">$1|$3";
		print ">$1";
	}
	if($_=~/^AC\s{3}(.*?)\;/m)
	{
		print "|$1";
	}
	if($_=~/^SQ   SEQUENCE\s+(.*?)\;/m)
	{
		print "|$1\n";
	}

#Second Line: the sequence

	while ($_=~/^\s{5}(.*)/mg)
	{
		$sequence=$1;
		$sequence=~s/\s//g;		
		print "$sequence";	#prints sequence of record
		
	    #filling up the array sequence (we need for third line originally in the project)
	 for ($a = 0 ; $a <= length($sequence) ; $a = $a + 1)
        {	
		   push(@sequence,$sequence); #creating an array sequence from the list sequence so that
                            		  #we can check out each element for the transmembrane regions 
		}   
		#keeping length of sequence array
		   $seq_length = scalar @sequence;
	}	
	
	print "\n";


#Third Line: Finding the transmembrane regions on the sequence 
		
	while($_=~/^FT\s{3}TRANSMEM\s+(\d+)\s+(\d+)\s+(.*)\./mg)
    {       
	    #finds all transmembrane regions on the sequence
	        $tmstart = $1;		#refers to first (\d+)
	        $tmend = $2;        #refers to second (\d+)
				
            for ($b = 0 ; $b <= $seq_length ; $b = $b + 1)
            {   
			    shift(@sequence); #returns first element of array sequence (do shift instead of pop that would return the last value)
				if(($b >= $tmstart) && ($b <= $tmend))
				{  
		        print "M"; #$b is in the transmembrane region 
				}
				else
				{   
                print "-"; #$b is not in the transmembrane region 
				}
            }
    }
        

	    print "\n";
		
#Fourth Line: End of each record on swiss file

        print "//";
        print "\n";


}