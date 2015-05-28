#!/bin/perl

use strict;
use warnings;

$| = 1;

my $playerName = 'kIesk';

my $cfgDirPath = '/cygdrive/c/Users/no/AppData/LocalLow/id Software/quakelive/home/baseq3';

my $insultCfgPath = "$cfgDirPath/klesk-insult.cfg";
my $insultTalkerCfgPath = "$cfgDirPath/klesk-insult-talker.cfg";
my $praiseCfgPath = "$cfgDirPath/klesk-praise.cfg";
my $tauntCfgPath = "$cfgDirPath/klesk-taunt.cfg";


####################################################################################################
# precompile some regex

my $gtRegexStr       = "^([A-Za-z0-9_]+) was pummeled by (?i)" . $playerName . "(?-i)\$";;
my $mgRegexStr       = "^([A-Za-z0-9_]+) was machinegunned by (?i)" . $playerName . "(?-i)\$";
my $sgRegexStr       = "^([A-Za-z0-9_]+) was gunned down by (?i)" . $playerName . "(?-i)\$";
my $glDirectRegexStr = "^([A-Za-z0-9_]+) ate (?i)" . $playerName . "(?-i)'s grenade\$";
my $glSplashRegexStr = "^([A-Za-z0-9_]+) was shredded by (?i)" . $playerName . "(?-i)'s shrapnel\$";
my $rlDirectRegexStr = "^([A-Za-z0-9_]+) ate (?i)" . $playerName . "(?-i)'s rocket\$";
my $rlSplashRegexStr = "^([A-Za-z0-9_]+) almost dodged (?i)" . $playerName . "(?-i)'s rocket\$";
my $lgRegexStr       = "^([A-Za-z0-9_]+) was electrocuted by (?i)" . $playerName . "(?-i)\$";
my $rgRegexStr       = "^([A-Za-z0-9_]+) was railed by (?i)" . $playerName . "(?-i)\$";
my $pgRegexStr       = "^([A-Za-z0-9_]+) was melted by (?i)" . $playerName . "(?-i)'s plasmagun\$";
my $ngRegexStr       = "^([A-Za-z0-9_]+) was nailed by (?i)" . $playerName . "(?-i)\$";
my $cgRegexStr       = "^([A-Za-z0-9_]+) got lead poisoning from (?i)" . $playerName . "(?-i)'s Chaingun\$";
my $telefragRegexStr = "^([A-Za-z0-9_]+) tried to invade (?i)" . $playerName . "(?-i)'s personal space\$";

my $gtRegex       = qr/$gtRegexStr/;
my $mgRegex       = qr/$mgRegexStr/;
my $sgRegex       = qr/$sgRegexStr/;
my $glDirectRegex = qr/$glDirectRegexStr/;
my $glSplashRegex = qr/$glSplashRegexStr/;
my $rlDirectRegex = qr/$rlDirectRegexStr/;
my $rlSplashRegex = qr/$rlSplashRegexStr/;
my $lgRegex       = qr/$lgRegexStr/;
my $rgRegex       = qr/$rgRegexStr/;
my $pgRegex       = qr/$pgRegexStr/;
my $ngRegex       = qr/$ngRegexStr/;
my $cgRegex       = qr/$cgRegexStr/;
my $telefragRegex = qr/$telefragRegexStr/;

####################################################################################################

MAINLOOP: while (<STDIN>)
{
    chomp($_);
    my $line = $_;
    $line =~ s/\^[0-9]//g;

    my $talkerName = extractTalkerName($line);
    my ($enemyName, $killedByRail, $killedByGaunt, $killedByBfg) = extractEnemyName($line);
    my ($victimName, $railedVictim, $gauntedVictim) = extractVictimName($line);

    if (length($talkerName) > 0) {
        writeInsult_random($talkerName);
    }

    if (length($enemyName) > 0) {
        if ($killedByRail) {
			writeInsult_rail($enemyName);			
        } elsif ($killedByGaunt) {
            writeInsult_gaunt($enemyName);
        } elsif ($killedByBfg) {
            writeInsult_bfg($enemyName);
        } else {
            writeInsult_genericDeath($enemyName);
        }
        writeInsult_deathPraise($enemyName);
    }

    if (length($victimName) > 0) {
        if ($railedVictim) {
			writeKill_rail($victimName);			
        } elsif ($gauntedVictim) {
            writeKill_gaunt($victimName);
        } else {
            writeKill_generic($victimName);
        }
    }
}

sub writeInsult_deathPraise {
	my @insultArray = ("Peace now. We thank.",
	"You alpha one. $_[0] make new race.",
	"Too easy for $_[0]...$_[0] is chosen.",
	"We come to your mind now, $_[0]. We stronger.",
	"Now you learn secret. We be you.",
	"Is sad.",
	"Bigger voice, $_[0], than all in me together."
	);

	my $randindex = rand(scalar @insultArray);
	
	open (FILE, '>', $praiseCfgPath); 
    print FILE "say $insultArray[$randindex]";
    close(FILE);


}

sub writeInsult_genericDeath {

	my @insultArray = ("Now We know mystery you not know, $_[0].",
	"Forever all know $_[0] kill Klesk. All hate $_[0].",
	"All is chaos! $_[0] win? No order to universe.",
	"Single-brainer $_[0] too stupid to find joy. No deserve.",
	"We devolve to $_[0] level. We fail.",
	"Colossal ridiculity is $_[0].",
	"We will find you, $_[0] ... kill body, swallow soul, scatter thoughts. Nothing of $_[0] remain."
	);

	my $randindex = rand(scalar @insultArray);
	
	open (FILE, '>', $insultCfgPath); 
    print FILE "say $insultArray[$randindex]";
    close(FILE);
	
	
}

sub writeInsult_rail {

	my @insultArray = ("No sense it. No happy.",
	"$_[0] ruins all world.",
	"No thoughts to sense. Just... ssssss... camper ...",
	"No good this destiny, $_[0]. We change. You get eat."
	);

	my $randindex = rand(scalar @insultArray);
	
	open (FILE, '>', $insultCfgPath); 
    print FILE "say $insultArray[$randindex]";
    close(FILE);


}

sub writeInsult_random {

	my @insultArray = ("We hear you, $_[0]. Your mind cry out inferior.",
	"We am many, you only one, $_[0].",
	"$_[0] voice run with spilling blood and gut. Is ecstacy.",
	"Better $_[0] serve as nest for egglings.",
	"Only great survive. $_[0] easy die.",
	"You think stupid, $_[0]. You weak! Klesk do favor killing you.",
	"There only black empty for $_[0]. No revelation."
	);

	my $randindex = rand(scalar @insultArray);
	
	open (FILE, '>', $insultTalkerCfgPath); 
    print FILE "say $insultArray[$randindex]";
    close(FILE);

}


sub writeInsult_bfg {

	my @insultArray = ("Too many poppers!",
	"Each voice get boom-boom.",
	"Shrieking! Too many noise. Too many hurt!",
	"My pieces make altar. You need to pray.",
	);

	my $randindex = rand(scalar @insultArray);
	
	open (FILE, '>', $insultCfgPath); 
    print FILE "say $insultArray[$randindex]";
    close(FILE);

}

sub writeInsult_gaunt {
	
	my @insultArray = ("Touch of single-brainer burns many.",
	"Energy scatter. Discord! Die, die, dying."
	);
	
	my $randindex = rand(scalar @insultArray);
	
	open (FILE, '>', $insultCfgPath); 
    print FILE "say $insultArray[$randindex]";
    close(FILE);


}


sub writeKill_rail {

	my @insultArray = ("We see you always, $_[0]. Nowhere to hide.",
	"Poke little hole in $_[0]. You spill out. Happy.",
	"Poor $_[0]. So much left, but voice is quiet."
	);

	my $randindex = rand(scalar @insultArray);
	
	open (FILE, '>', $tauntCfgPath); 
    print FILE "say $insultArray[$randindex]";
    close(FILE);


}


sub writeKill_gaunt {

	my @insultArray = ("Close ... close, $_[0]. We smell you fear of die.",
	"We watch light leave eyes of $_[0]. We like."
	);

	my $randindex = rand(scalar @insultArray);
	
	open (FILE, '>', $tauntCfgPath); 
    print FILE "say $insultArray[$randindex]";
    close(FILE);

}


sub writeKill_generic {

	my @insultArray = ("My egglings in you hatch, $_[0].",
	"Much happiness me. I wish you back so kill you over again.",
	"To followers We feed you.",
	"One little voice to silence. Not enough, but happy.",
	"$_[0] mind weak, body weak. It follows. Too easy.",
	"Glide on $_[0] spill guts. Dance of joy.",
	"Hollow skull, make $_[0] candle. Need focus."
	);

	my $randindex = rand(scalar @insultArray);
	
	open (FILE, '>', $tauntCfgPath); 
    print FILE "say $insultArray[$randindex]";
    close(FILE);

}

####################################################################################################
####################################################################################################

# returns array ($enemyName, $killedByRail, $killedByGaunt, $killedByBfg)
sub extractEnemyName {
    my ( $line ) = @_;

    if ($line =~ /^$playerName/i) {
        if ($line =~ /was pummeled by ([A-Za-z0-9_]+)$/) {
            return ($1, 0, 1, 0);
        }
        if ($line =~ /was machinegunned by ([A-Za-z0-9_]+)$/) {
            return ($1, 0, 0, 0);
        }
        if ($line =~ /was gunned down by ([A-Za-z0-9_]+)$/) {
            return ($1, 0, 0, 0);
        }
        if ($line =~ /ate ([A-Za-z0-9_]+)'s grenade$/) {
            return ($1, 0, 0, 0);
        }
        if ($line =~ /was shredded by ([A-Za-z0-9_]+)'s shrapnel$/) {
            return ($1, 0, 0, 0);
        }
        if ($line =~ /ate ([A-Za-z0-9_]+)'s rocket$/) {
            return ($1, 0, 0, 0);
        }
        if ($line =~ /almost dodged ([A-Za-z0-9_]+)'s rocket$/) {
            return ($1, 0, 0, 0);
        }
        if ($line =~ /was electrocuted by ([A-Za-z0-9_]+)$/) {
            return ($1, 0, 0, 0);
        }
        if ($line =~ /was railed by ([A-Za-z0-9_]+)$/) {
            return ($1, 1, 0, 0);
        }
        if ($line =~ /was melted by ([A-Za-z0-9_]+)'s plasmagun$/) {
            return ($1, 0, 0, 0);
        }
        if ($line =~ /was nailed by ([A-Za-z0-9_]+)$/) {
            return ($1, 0, 0, 0);
        }
        if ($line =~ /got lead poisoning from ([A-Za-z0-9_]+)'s Chaingun$/) {
            return ($1, 0, 0, 0);
        }
        if ($line =~ /tried to invade ([A-Za-z0-9_]+)'s personal space$/) {
            return ($1, 0, 0, 0);
        }
        # TODO bfg and other silly weapons
    }
    return ('', 0, 0, 0);
}


# returns array ($victimName, $railedVictim, $gauntedVictim)
sub extractVictimName {
    my ( $line ) = @_;

    if ($line =~ $gtRegex) {
        return ($1, 0, 1);
    }
    if ($line =~ $mgRegex) {
        return ($1, 0, 0);
    }
    if ($line =~ $sgRegex) {
        return ($1, 0, 0);
    }
    if ($line =~ $glDirectRegex) {
        return ($1, 0, 0);
    }
    if ($line =~ $glSplashRegex) {
        return ($1, 0, 0);
    }
    if ($line =~ $rlDirectRegex) {
        return ($1, 0, 0);
    }
    if ($line =~ $rlSplashRegex) {
        return ($1, 0, 0);
    }
    if ($line =~ $lgRegex) {
        return ($1, 0, 0);
    }
    if ($line =~ $rgRegex) {
        return ($1, 1, 0);
    }
    if ($line =~ $pgRegex) {
        return ($1, 0, 0);
    }
    if ($line =~ $ngRegex) {
        return ($1, 0, 0);
    }
    if ($line =~ $cgRegex) {
        return ($1, 0, 0);
    }
    if ($line =~ $telefragRegex) {
        return ($1, 0, 0);
    }
    # TODO bfg and other silly weapons

    return ('', 0, 0);
}

sub extractTalkerName {
    my ( $line ) = @_;

    if ($line =~ /^ ([^:]*[^])]):/) {
        my $name = $1;
        
        # not necessary, but just to be sure
        if ($name =~ /^\s*<QUAKE LIVE>/) {
            return '';
        }

        # remove clan tag if there is one
        $name =~ s/^\S+\s+(.*)$/$1/;

        # ensure name only contains valid characters to be safe
        if ($name =~ /^[A-Za-z0-9_]+$/) {
            # and is not our name
            ($playerName =~ /[A-Za-z0-9_]+/) || die '$playerName is an invalid quake name!';
            if ($name =~ /^$playerName$/i) {
                return '';
            }
            return $name;
        } else {
            return '';
        }
    }

    return '';
}  
