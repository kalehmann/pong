# Pong in assembler as a bootloader for an x86_64 machine

![screenshot](https://raw.githubusercontent.com/kalehmann/pong/master/pong_screenshot.png)

## What is this project?
When booting a x86_64 machine, the BIOS loads the first 512 bytes from the selected hard drive. The purpose of this project is to use only these 512 bytes and the BIOS interupts to make a fully functional clone of Pong.

## How to run this project?
To build this project you need to install the assembler [NASM](http://www.nasm.us/) first. After that you can simply run ```$ make``` too build this project. Now you got the file **floppy.img** which you can run with qemu by using the comand ```# qemu-system-x86_64 -fda floppy.img```

## How to play this game?
This game is for two players. The player with the color red can be seen at the top and the blue player at the bottom of the screen. The blue player can be moved with the arrow keys and the red player with the keys **a** and **d**. The goal is to prevent the moving pink square from hitting the top or bottom of the screen. Unfortunately there is no event for winning the game. 

## What are the limits of this project?
Sadly I did not work efficient enough to manage to print out the score as a number with only 512 bytes of memory. Therefore the score is printed in letters upwards from *a* to *z*, but does not stop at z. The game also flickers sometimesa little bit, but is overall playable. Maybe you should not play it, if you are known for epileptic seizures. Last but not least this is a multiplayer game, but the players can not make inputs simultanously.
