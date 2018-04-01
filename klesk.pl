#!/bin/perl

use strict;
use warnings;
use Getopt::Long;

use constant DEBUG => 1;

# Forces no-buffering
$| = 1;

my $baseq3_dir = 0;
my $player_name = 0;

GetOptions ('dir=s' => \$baseq3_dir,
  'name=s' => \$player_name);

die("Insufficient arguments! Exiting.") if !$baseq3_dir or !$player_name;


my $cfg_insult = "$baseq3_dir/klesk-insult.cfg";
my $cfg_insult_talker = "$baseq3_dir/klesk-insult-talker.cfg";
my $cfg_praise = "$baseq3_dir/klesk-praise.cfg";
my $cfg_taunt = "$baseq3_dir/klesk-taunt.cfg";


# In case these need to be specially tailored.
my $victim_name_regex_str = "(.*)";
my $enemy_name_regex_str = "(.*)";


# Regex strings used to match console output
my $victim_gt_regex_str = "$victim_name_regex_str was pummeled by $player_name\$";
my $victim_mg_regex_str = "$victim_name_regex_str was machinegunned by $player_name\$";
my $victim_sg_regex_str = "$victim_name_regex_str was gunned down by $player_name\$";
my $victim_gl_direct_regex_str = "$victim_name_regex_str ate $player_name\'s grenade\$";
my $victim_gl_splash_regex_str = "$victim_name_regex_str was shredded by $player_name\'s shrapnel\$";
my $victim_rl_direct_regex_str = "$victim_name_regex_str ate $player_name\'s rocket\$";
my $victim_rl_splash_regex_str = "$victim_name_regex_str almost dodged $player_name\'s rocket\$";
my $victim_lg_regex_str = "$victim_name_regex_str was electrocuted by $player_name\$";
my $victim_rg_regex_str = "$victim_name_regex_str was railed by $player_name\$";
my $victim_pg_regex_str = "$victim_name_regex_str was melted by $player_name\'s plasmagun\$";
my $victim_ng_regex_str = "$victim_name_regex_str was nailed by $player_name\$";
my $victim_cg_regex_str = "$victim_name_regex_str got lead poisoning from $player_name\'s Chaingun\$";
my $victim_bfg_regex_str = "$victim_name_regex_str was blasted by $player_name\'s BFG\$";
my $victim_telefrag_regex_str = "$victim_name_regex_str tried to invade $player_name\'s personal space\$";

my $enemy_gt_regex_str = "$player_name was pummeled by $enemy_name_regex_str\$";
my $enemy_mg_regex_str = "$player_name was machinegunned by $enemy_name_regex_str\$";
my $enemy_sg_regex_str = "$player_name was gunned down by $enemy_name_regex_str\$";
my $enemy_gl_direct_regex_str = "$player_name ate $enemy_name_regex_str\'s grenade\$";
my $enemy_gl_splash_regex_str = "$player_name was shredded by $enemy_name_regex_str\'s shrapnel\$";
my $enemy_rl_direct_regex_str = "$player_name ate $enemy_name_regex_str\'s rocket\$";
my $enemy_rl_splash_regex_str = "$player_name almost dodged $enemy_name_regex_str\'s rocket\$";
my $enemy_lg_regex_str = "$player_name was electrocuted by $enemy_name_regex_str\$";
my $enemy_rg_regex_str = "$player_name was railed by $enemy_name_regex_str\$";
my $enemy_pg_regex_str = "$player_name was melted by $enemy_name_regex_str\'s plasmagun\$";
my $enemy_ng_regex_str = "$player_name was nailed by $enemy_name_regex_str\$";
my $enemy_cg_regex_str = "$player_name got lead poisoning from $enemy_name_regex_str\'s Chaingun\$";
my $enemy_bfg_regex_str = "$player_name was blasted by $enemy_name_regex_str\'s BFG\$";
my $enemy_telefrag_regex_str = "$player_name tried to invade $enemy_name_regex_str\'s personal space\$";


# so we can substitute names in later.
my $target_name_replace_string = "___name___";

# insult arrays
my @insult_array_death_praise = ("Peace now. We thank.",
  "You alpha one. $target_name_replace_string make new race.",
  "Too easy for $target_name_replace_string...$target_name_replace_string is chosen.",
  "We come to your mind now, $target_name_replace_string. We stronger.",
  "Now you learn secret. We be you.",
  "Is sad.",
  "Bigger voice, $target_name_replace_string, than all in me together."
  );

my @insult_array_death_rail = ("No sense it. No happy.",
  "$target_name_replace_string ruins all world.",
  "No thoughts to sense. Just... ssssss... camper ...",
  "No good this destiny, $target_name_replace_string. We change. You get eat."
  );

my @insult_array_death_bfg = ("Too many poppers!",
  "Each voice get boom-boom.",
  "Shrieking! Too many noise. Too many hurt!",
  "My pieces make altar. You need to pray.",
  );

my @insult_array_death_gaunt = ("Touch of single-brainer burns many.",
  "Energy scatter. Discord! Die, die, dying."
  );

my @insult_array_death = ("Now We know mystery you not know, $target_name_replace_string.",
  "Forever all know $target_name_replace_string kill Klesk. All hate $target_name_replace_string.",
  "All is chaos! $target_name_replace_string win? No order to universe.",
  "Single-brainer $target_name_replace_string too stupid to find joy. No deserve.",
  "We devolve to $target_name_replace_string level. We fail.",
  "Colossal ridiculity is $target_name_replace_string.",
  "We will find you, $target_name_replace_string ... kill body, swallow soul, scatter thoughts. Nothing of $target_name_replace_string remain."
  );

my @insult_array_random = ("We hear you, $target_name_replace_string. Your mind cry out inferior.",
  "We am many, you only one, $target_name_replace_string.",
  "$target_name_replace_string voice run with spilling blood and gut. Is ecstacy.",
  "Better $target_name_replace_string serve as nest for egglings.",
  "Only great survive. $target_name_replace_string easy die.",
  "You think stupid, $target_name_replace_string. You weak! Klesk do favor killing you.",
  "There only black empty for $target_name_replace_string. No revelation."
  );

my @insult_array_kill_rail = ("We see you always, $target_name_replace_string. Nowhere to hide.",
  "Poke little hole in $target_name_replace_string. You spill out. Happy.",
  "Poor $target_name_replace_string. So much left, but voice is quiet."
  );

my @insult_array_kill_gaunt = ("Close ... close, $target_name_replace_string. We smell you fear of die.",
  "We watch light leave eyes of $target_name_replace_string. We like."
  );

my @insult_array_kill = ("My egglings in you hatch, $target_name_replace_string.",
  "Much happiness me. I wish you back so kill you over again.",
  "To followers We feed you.",
  "One little voice to silence. Not enough, but happy.",
  "$target_name_replace_string mind weak, body weak. It follows. Too easy.",
  "Glide on $target_name_replace_string spill guts. Dance of joy.",
  "Hollow skull, make $target_name_replace_string candle. Need focus."
  );


sub extract_victim_name {
  my ( $line ) = @_;
  my $victim_name = '';
  my $victim_gaunt_status = 0;
  my $victim_rail_status = 0;
  my $victim_bfg_status = 0;

  if($line =~ qr/$victim_gt_regex_str/i) {
    $victim_name = $1;
    $victim_gaunt_status = 1;
  }

  if($line =~ qr/$victim_rg_regex_str/i) {
    $victim_name = $1;
    $victim_rail_status = 1;
  }

  if($line =~ qr/$victim_bfg_regex_str/i) {
    $victim_name = $1;
    $victim_bfg_status = 1;
  }

  $victim_name = $1 if $line =~ qr/$victim_mg_regex_str/i;
  $victim_name = $1 if $line =~ qr/$victim_sg_regex_str/i;
  $victim_name = $1 if $line =~ qr/$victim_gl_direct_regex_str/i;
  $victim_name = $1 if $line =~ qr/$victim_gl_splash_regex_str/i;
  $victim_name = $1 if $line =~ qr/$victim_rl_direct_regex_str/i;
  $victim_name = $1 if $line =~ qr/$victim_rl_splash_regex_str/i;
  $victim_name = $1 if $line =~ qr/$victim_lg_regex_str/i;
  $victim_name = $1 if $line =~ qr/$victim_pg_regex_str/i;
  $victim_name = $1 if $line =~ qr/$victim_ng_regex_str/i;
  $victim_name = $1 if $line =~ qr/$victim_cg_regex_str/i;
  $victim_name = $1 if $line =~ qr/$victim_telefrag_regex_str/i;

  return ($victim_name, $victim_rail_status, $victim_gaunt_status, $victim_bfg_status);
}


sub extract_enemy_name {
  my ( $line ) = @_;
  my $enemy_name = '';
  my $enemy_gaunt_status = 0;
  my $enemy_rail_status = 0;
  my $enemy_bfg_status = 0;


  if($line =~ qr/$enemy_gt_regex_str/i) {
    $enemy_name = $1;
    $enemy_gaunt_status = 1;
  }

  if($line =~ qr/$enemy_rg_regex_str/i) {
    $enemy_name = $1;
    $enemy_rail_status = 1;
  }

  if($line =~ qr/$enemy_bfg_regex_str/i) {
    $enemy_name = $1;
    $enemy_bfg_status = 1;
  }

  $enemy_name = $1 if $line =~ qr/$enemy_mg_regex_str/i;
  $enemy_name = $1 if $line =~ qr/$enemy_sg_regex_str/i;
  $enemy_name = $1 if $line =~ qr/$enemy_gl_direct_regex_str/i;
  $enemy_name = $1 if $line =~ qr/$enemy_gl_splash_regex_str/i;
  $enemy_name = $1 if $line =~ qr/$enemy_rl_direct_regex_str/i;
  $enemy_name = $1 if $line =~ qr/$enemy_rl_splash_regex_str/i;
  $enemy_name = $1 if $line =~ qr/$enemy_lg_regex_str/i;
  $enemy_name = $1 if $line =~ qr/$enemy_pg_regex_str/i;
  $enemy_name = $1 if $line =~ qr/$enemy_ng_regex_str/i;
  $enemy_name = $1 if $line =~ qr/$enemy_cg_regex_str/i;
  $enemy_name = $1 if $line =~ qr/$enemy_telefrag_regex_str/i;

  return ($enemy_name, $enemy_rail_status, $enemy_gaunt_status, $enemy_bfg_status);
}


MAINLOOP: while (<STDIN>) {
  chomp($_);
  my $line = $_;

  # Strip colours
  $line =~ s/\^[0-9]//g;

  my $victim_name = '';
  my $victim_gaunt_status = 0;
  my $victim_rail_status = 0;
  my $victim_bfg_status = 0;

  my $enemy_name = '';
  my $enemy_gaunt_status = 0;
  my $enemy_rail_status = 0;
  my $enemy_bfg_status = 0;

  my $talker_name = '';

  ($victim_name, $victim_rail_status, $victim_gaunt_status, $victim_bfg_status) = extract_victim_name($line);
  ($enemy_name, $enemy_rail_status, $enemy_gaunt_status, $enemy_bfg_status) = extract_enemy_name($line);

  my $write_string = '';
  my @write_string_list = ();
  my $write_string_rand_index = 0;

  if($victim_name) {
    if ($victim_rail_status) {
      @write_string_list = @insult_array_kill_rail;
    } elsif ($victim_gaunt_status) {
      @write_string_list = @insult_array_kill_gaunt;
    } else {
      @write_string_list = @insult_array_kill;
    }

    $write_string_rand_index = rand(scalar @write_string_list);
    $write_string = $write_string_list[$write_string_rand_index];
    $write_string =~ s/$target_name_replace_string/$victim_name/;
    open (FILE, '>', $cfg_taunt) or die "Unable to open cfg for writing! Exiting.";
    print FILE "say $write_string";
    close(FILE);
  } elsif($enemy_name) {

    if ($enemy_rail_status) {
      @write_string_list = @insult_array_death_rail;
    } elsif ($enemy_gaunt_status) {
      @write_string_list = @insult_array_death_gaunt;
    } elsif ($enemy_bfg_status) {
      @write_string_list = @insult_array_death_bfg;
    } else {
      @write_string_list = @insult_array_death;
    }

    $write_string_rand_index = rand(scalar @write_string_list);
    $write_string = $write_string_list[$write_string_rand_index];
    $write_string =~ s/$target_name_replace_string/$enemy_name/;
    open (FILE, '>', $cfg_insult) or die "Unable to open cfg for writing! Exiting.";
    print FILE "say $write_string";
    close(FILE);

    # Write praise
    $write_string_rand_index = rand(scalar @insult_array_death_praise);
    $write_string = $insult_array_death_praise[$write_string_rand_index];
    $write_string =~ s/$target_name_replace_string/$enemy_name/;
    open (FILE, '>', $cfg_praise) or die "Unable to open cfg for writing! Exiting.";
    print FILE "say $write_string";
    close(FILE);
  } elsif($line =~ /(.*):/i) {
    $talker_name = $1;

    $write_string_rand_index = rand(scalar @insult_array_random);
    $write_string = $insult_array_random[$write_string_rand_index];
    $write_string =~ s/$target_name_replace_string/$talker_name/;
    open (FILE, '>', $cfg_insult_talker) or die "Unable to open cfg for writing! Exiting.";
  }
}
