# ios-decal-final-proj
The iOS decal final project repository

# Protect Them!

## Authors
- Amy Ji                amyji@berkeley.edu
- Ziwei Yin             zwyin2013@berkeley.edu
- Enkhtushig Namkhai    enamkhai@berkeley.edu

## Purpose
A tower-defense fangame featuring a korean band called EXO. In this game, you will be protecting your bias from enemies and getting their superpowers back.

## Features
- A small intro story that walks you through the basics of the game
- A page to choose the idol you want to protect
- Once you choose your idol, you will be playing the tower-defense game with different initial settings including armor, superpower and enemies.
- 2 different endings, one where you successfully save your idol and live happily ever after, another one where you fail and get kidnapeed with your idol by your enemies.

## Control Flow
- When users start the app, they will see the a game start page where they choose which idol they want to defend
- Once the user chooses an idol, they will be directed to an intro story page where they can read the background story. The user has to keep clicking "continue" to go through the storyline view by view. (about 6 views in total)
- At the end of the intro story, there will be a page asking the user to start the game. After clicking a "Defend" button, the user will be directed to the tower-defense game view.
- For each game, there are three types of defense weapons, three types of enemies and a common 8*8 checkboard in total. We will assign each idol a unique map (path for enemies), unique amount of enemies, unique amount of starting energy and unique amount of life. When enemies are killed, the user will receive a certain amount of energy according the the type of enemy killed. If the enemy reached the tower (idol), the user will some life according to the type of enemy.
- Each game lasts 120 seconds. If an idol's life reaches zero, the user loses the game and is redirected to the losing view. If user survived, he/she will be directed to the winning view.
- The losing page will contain a "startover" button and a "defend another idol" button so user can chooes to startover with the same idol or go back to the starting view of game. The winning page will contain a "Defend another idol" button, where he/she will be redirected to the starting view of game.

##Implementation
### Model
- idol.swift
- weapon.swift
- enemy.swift
- map.swift
- board.swift
- game.swift

### Views
- StartUIView
- StoryIUIView * 6
- EnterGameUIView
- GameView
- LosingUIView
- WinningUIView

### Controller
- StartUIViewController
- StoryIUIViewController * 6
- EnterGameUIViewController
- GameViewController
- LosingUIViewController
- WinningUIViewController

