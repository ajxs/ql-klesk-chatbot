# ql-klesk-chatbot
A script to allow a Quake live player to imitate the proper dynamic bot-chatter of Quake 3's Klesk bot in-game.

## About
This script was created back in 2014 by CaptainTaichou and myself, with the intention of allowing a Quake Live player to imitate the idiosyncratic bot chatter of the Quake3 bot 'Klesk'. The script functions by 'tailing' the qconsole.log file and piping each line to STDIN of the klesk.pl script, which in turn parses the console output to create the appropriate response lines in a series of .cfg files which can be executed in-game.
The script allows the user to insult or praise the last player to kill the user, taunt the user's last victim, or insult the last talking player. The script includes all the relevant Klesk insults from the original Quake 3.

Since Quake Live can't be run in Linux anymore, you'll need some form of terminal emulator like Cygwin. Unless of course you can find a native Windows way to pipe lines to the parser. I suspect this is possible with Powershell, but at the time of writing I have not attempted this.
This kind of script is capable of much more than simply imitating Klesk, but we'll leave that functionality up to you to explore!
And no, this won't get you banned.

## How to run the script

Firstly you'll need to alter the `run.sh` bash script to point to your steam client's `baseq3` folder, as well as specify the username you'll be playing as. ( More than likely this will be 'Klesk' )
When run, the script will copy `klesk.cfg` to your `baseq3` folder if it is not already present, this file sets the correct logging level, as well as sets up a few basic binds. Feel free to alter these to suit your config. You will need to execute this script in the console using `exec klesk` before it will be active.

The resulting binds are:
`exec klesk-insult` - Insult the last person to kill you.
`exec klesk-insult-talker` - Insult the last person to talk.
`exec klesk-praise` - Praise the last person to kill you.
`exec klesk-taunt` - Taunt the last person you killed.

glhf!
