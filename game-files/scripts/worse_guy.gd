### PATH FOLLOWING ENEMY ###
# REQUIRES A PARENT PATH2D NODE
# FOLLOWS GIVEN PATH
# TODO: ATTACK PLAYER OR LEAVE

extends PathFollow2D
@export var speed : float = 100
@export var direction : Vector2 = Vector2.ZERO
@export var damage : int = 1
@export var health : int = 1
@export var score_value : int = 500

@export var difficulty_tick : int = 10 # How often difficulty tick happens
@export var delta_health : int = 1 # Amount of health increase
@export var delta_speed : float = 1.1 # Amount speed changes every tick
@export var delta_score : int = 250 # Amount score changes every tick
func _ready():
	health += Globals.INCREASED_HEALTH

func _process(delta):
	move(delta)

func move(delta):
	progress += speed * delta * Globals.SPEED_MULT  

func destroy(killed):
	if(killed):
		if Globals.KILLS % difficulty_tick == 0 and Globals.KILLS != 0: # Every tenth kill, 
			Globals.INCREASED_HEALTH += delta_health # Enemies require 1 more hit
			Globals.SPEED_MULT *= delta_speed # Enemies move 10% faster
			Globals.SCORE_BUFF += delta_score  # Enemies now give 250 more points
			print('difficulty increase')
		Globals.SCORE = Globals.SCORE + score_value + Globals.SCORE_BUFF
		print("Score: ", Globals.SCORE)
	queue_free()

func hurt(dam):
	health -= dam
	if health <= 0:
		destroy(true)
