# smrpg-contest-bot
SMRPG Contest Bot

This is a mIRC script bot that facilitates guessing game contests in your chat during super mario rpg speedruns:
- How many bombs will Croco toss (bad RNG lolol)
- What will the runner's minecart time be? (watch my tutorial video)
- How many flowers will the runner get on Booster Hill? (worst minigame)
- How many sandstorms will Raspberry use? (this fight sucks)

The streamer or a mod has to type **!guess** to start the 1 min submission window and then **!end *number or time*** after to finish w/ the correct answer, and it goes in order so you dont have to manually advance the game or whatever.

The streamer or a mod can use **!reset** to set it back so that the next one will be croco bomb toss.

Whoever guesses correctly or the closest gets points (within reason). points don't do anything, they're just for bragging rights.

Put these files in your scripts folder of your mIRC installation. Read https://help.twitch.tv/customer/portal/articles/1302780-twitch-irc#MIRC if you don't know how to use mIRC with twitch, you will need to make your own secondary bot account to run this.

Just replace "#pidgezero_one" in my code everywhere with your twitch name.

Also includes a basic quote DB function and a script that generates a lenny face meme every 15-20 mins