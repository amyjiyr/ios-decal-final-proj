# ios-decal-final-proj
The iOS decal final project repository

# Protect Exo Game

## Authors
- Amy Ji
- Ziwei Yin
- Enkhtushig Namkhai

## Purpose
A tower-defense fangame featuring a korean band called EXO. In this game, you will be protecting your bias from enemies and getting their superpowers back

## Features
- A small intro story that walks you through the basics of the game
- A page to choose the idol you want to protect
- Once you choose your idol, you will be playing the tower-defense game with different initial settings including armor, superpower and enemies.
- 2 different endings, one where you successfully save your idol and live happily ever after, another one where you fail and get kidnapeed with your idol by your enemies.

## Control Flow
- When users start the app, they will see the a game start page where you choose which idol you want to defend
- Once the user chooses an idol, they will be led to an intro story page where they can read the background story. The user has to keep clicking "continue" to go through the storyline view by view. (about 6 views in total)
- At the end of the intro story, there will be a page asking the user to start the game. After clicking a "Defend" button, the user will be re-directed to the tower-defense game view.
- There are total three different kinds of defense weapons, three types of enemies and a common 8*8 checkboard. We will assign each idol a unique map (path for enemies), unique amount of enemies, unique amount of starting energy and unique amount of blood points. When enemies are killed, the user will receive a certain amount of energy according the the type of enemy killed. If the enemy reached the tower (idol), the user will lose blood points according to the type of enemy.
- The time for each game is 120 seconds. If the blood points reaches zero, then the user will lose and be redirected to the lossing view. If user survived, he/she will be redirected to the winning view.
- The loosing page will contain a "startover" button and a "defend another idol" button while the user can startover with the same idol or back to the first view of game. The winning page will contain a "Defend another idol" button, where he/she will be redirected to the first view of game.

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

