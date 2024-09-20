extends Node

var SCORE : int = 0
var LIVES : int = 3
var BASIC_ODDS : int = 70
var SPECIAL_ODDS : int = 20
var RARE_ODDS : int = 10

var KILLS : int = 0 # Actual number of enemies defeated
#var INCREASED_HEALTH : int = 0 # How many extra hits are required because of the difficulty
var SPEED_MULT : float = 1.0 # How much to multiply the speed by as the difficulty increases
var SCORE_BUFF : int = 0 # How many extra points are added because of difficulty
var SPAWN_INCREASE : float = 1.0 # Decreases intervals between spawns
func _ready():
	pass 



func _process(_delta):
	pass

func reset_difficulty():
	SCORE = 0
	LIVES = 3
	KILLS  = 0 # Actual number of enemies defeated
	#INCREASED_HEALTH = 0 # How many extra hits are required because of the difficulty
	SPEED_MULT = 1.0 # How much to multiply the speed by as the difficulty increases
	SCORE_BUFF = 0 # How many extra points are added because of difficulty
