extends Node

@onready var coins = $"../Labels/Coins"

var score = 0

func add_point():
	score += 1
	coins.text = "You collected " + str(score) + " coins !"
