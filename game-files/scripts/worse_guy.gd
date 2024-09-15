### PATH FOLLOWING ENEMY ###
# REQUIRES A PARENT PATH2D NODE
# FOLLOWS GIVEN PATH
# TODO: ATTACK PLAYER OR LEAVE

extends PathFollow2D
@export var speed : int = 100
@export var direction : Vector2 = Vector2.ZERO
@export var damage : int = 1
@export var health : int = 1
@export var score_value : int = 5

func _ready():
	pass 

func _process(delta):
	move(delta)

func move(delta):
	progress += speed * delta

func destroy(killed):
	if(killed):
		Globals.SCORE += score_value
		print("Score: ", Globals.SCORE)
	queue_free()

func hurt(dam):
	health -= dam
	if health <= 0:
		destroy(true)
