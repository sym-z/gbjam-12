extends Node

var CHANGE_AT = 10
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
var LAST_BUMP : int = 0 # Marks the last difficulty bump, prevents multiple bumps
var CAN_CHANGE : bool = true
var timer

var HIGH_SCORE : int = 0
### TO FIGURE OUT DIRECTION OF SPAWN ###
enum DIR {NORTH, SOUTH, EAST, WEST}
var filled_gates = {
	DIR.NORTH : 0,
	DIR.SOUTH : 0,
	DIR.EAST  : 0,
	DIR.WEST  : 0
} 

func _ready():
	timer = Timer.new()
	timer.wait_time =1.0
	timer.one_shot = true
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)

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

func raise_difficulty(delta_score):
	#SPEED_MULT *= delta_speed # Enemies move 10% faster
	SCORE_BUFF += delta_score  # Enemies now give 250 more points
	CAN_CHANGE = false
	timer.start()
	#print('difficulty pause start')

func _on_timer_timeout():
	CAN_CHANGE = true
	#print('difficulty pause stop')
