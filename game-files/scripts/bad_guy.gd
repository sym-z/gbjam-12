extends Node2D
@export var speed : float = 25
@export var direction : Vector2 = Vector2.ZERO
@export var damage : int = 1
@export var health : int = 1
@export var score_value : int = 250

@export var difficulty_tick : int = 10 # How often difficulty tick happens
@export var delta_health : int = 1 # Amount of health increase
@export var delta_speed : float = 1.1 # Amount speed changes every tick
@export var delta_score : int = 250 # Amount score changes every tick
func _ready():
	#health += Globals.INCREASED_HEALTH
	pass
func _process(delta):
	move(delta)

func move(delta):
	position += ((speed * direction) * delta ) * Globals.SPEED_MULT

func destroy(killed):
	if(killed):
		print(Globals.KILLS)
		if Globals.KILLS % difficulty_tick == 0 and Globals.KILLS != 0: # Every tenth kill, 
			print(Globals.SPEED_MULT)
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
