#!/usr/bin/env perl

@pots = "";
foreach (1 .. 12){
    $pots[$_] = 4;}
$pots[0]=0;
$pots[13]=0;

sub update {

$i = 1;
$nada = 0;

#clear screen

system $^O eq 'MSWin32' ? 'cls' : 'clear';

# draw board

while ($i<7){
    print "$pots[$i]  ";
    $nada += $pots[$i];
    $i++;}
print "\n";
if ($nada == 0) {&victory;}
$nada = 0;
while ($i<13){
    print "$pots[$i]  ";
    $nada += $pots[$i];
    $i++;}
print "\n";
if ($nada == 0) {&victory;}
print "To me: $pots[0]\n";
print "To you: $pots[13]\n";
}

while (1){
&update;

sub getmove{
# get the player's move
print "Your move\n";
chomp ($move = <STDIN> + 6);

# make the player's move
$inplay = $pots[$move];
$offset = 1;
$pots[$move] = 0;
}

&getmove;
&move (14,1);

if ($move > 6 && $move < 13 && $pots[$move]==1){$pots[13] += $pots[$move-6]; $pots[$move-6]=0;}



&update;
sub machine{
#get the computer's move
$move = int( rand(5)) + 1;
until ($pots[$move]>0){$move ++;}
if ($move > 6){ $move = 1; }
until ($pots[$move]>0){$move ++;}
# make the computer's move
$inplay = $pots[$move];
$offset = -1;
$pots[$move] = 0;
print "My move\n";
}
&machine;
&move (13,-1);
if ($move > 0 && $move < 7 && $pots[$move]==1){$pots[0] += $pots[$move+6]; $pots[$move+6]=0;}

sleep 1;
}

sub move{

while ($inplay) {
    
    $move+= $offset;
    if ($move == $_[0]) {$move = 6; $offset = -1;}
    if ($move == $_[1]) {$move = 7; $offset = 1;}
    $pots[$move]++;
    $inplay--;}
if ($move==13){&update; &getmove; &move (14,1)}  
if ($move==0){&update; &machine; &move(13,-1);}
}

sub victory{

    print "Game over. You have ";
    if ($pots[0] < $pots[13]) {print "won.\n"; exit;}
    elsif ($pots[13] < $pots[0]) {print "lost.\n"; exit;}
    print "neither won nor lost, as is often the way.\n"; exit;
}
