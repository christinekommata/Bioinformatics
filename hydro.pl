$x='MNFLWKGRRFLIAGILPTFEGAADEIVDKENKTYKAFLASKPPEETGLERLKQMFTIDEFGSISSELNSVYQAGFLGFLIGAIYGGVTQSRVAYMNFMENNQATAFKSHFDAKKKLQDQFTVNFAKGGFKWGWRVGLFTTSYFGIITCMSVYRGKSSIYEYLAAGSITGSLYKVSLGLRGMAAGGIIGGFLGGVAGVTSLLLMKASGTSMEEVRYWQYKWRLDRDENIQQAFKKLTEDENPELFKAHDEKTSEHVSLDTIK';
$k=7; #megethos parathiroy einai symmetriko k einai 2k+1 dhladh 11

@hydrovalue=(); #orismos pinaka poy apouhkeuei tis meses times ydrobobikothtas gia kaue parathiro

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
	  );
	  
	  
	  
for($i=$k; $i<length($x)-$k;$i++){   #diabazei thn akolouthia k vriskei thn kenrikh timh toy parathyrou
	$q=0;
	
	for($j=$i-$k; $j<=$i+$k; $j++){     #vriskei ta stoixeia prin k meta thn kenrikh timh toy parathyrou
		$a=substr($x,$j,1);            #orizv to parathyro
		
		#print "$a";  #typonei to parauyro
		
		$p=$hyd{$a}; #upologizei tis ydribobikothtes toy kathe aminokseos
		$q=$q+$p;  #athrizei tis ydrobobikothtes tvn aminoksevn enos parathiroy
	}
	$q=$q/(2*$k+1); #vriskei th mesh timh ths ydrobobikothtas enos parathiroy
	$hydrovalue[$i]=$q; #bazei se enan pinaka k antistoixei th mesh timh sto meso aminoksi toy parathiroy
	$t=substr($x,$i,1);  #vriskei to meso aminoksi enos parathiroy
	print "$i\t$t\t$hydrovalue[$i]";  #typonei th thesi toy aminokseos to meso amonoksi k th mesh ydrobobikothta toy parauyrou gyrv apo ayto to aminiksi
        print"\n";	
	
}

#vazo ayta poy typvnei ayto se ena excel me treis steiles k kano ena grafhma me mia sthlh th uesh toy aminokeos k thn allh thm timh ths ydrobobikothtas k bgainei h grafikh parastash

