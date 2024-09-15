extends Node2D
@export var speed : int = 5
@export var direction : Vector2 = Vector2.ZERO
### CIRCLING ENEMY ###
# FOLLOWS SET CIRCULAR PATH
# TODO: ATTACK PLAYER OR LEAVE

@export var damage : int = 1
@export var health : int = 1
@export var score_value : int = 5
@export var radius : int = 35
# What is being rotated
@export var body : Node2D

func _ready():
	### ASSIGN VALUES FOR POSITIONING ###
	var CENTERX = get_viewport_rect().size.x / 2
	var CENTERY = get_viewport_rect().size.y / 2
	# Align Orbit
	### USED THIS FOR HELP ###
	### https://forum.godotengine.org/t/how-to-make-ideal-circle-path2d-in-simple-way/26750 ###
	position = Vector2(CENTERX,CENTERY)
	body.position = Vector2(radius, 0)
	
	pass 

func _process(delta):
	move(delta)

func move(delta):
	rotation += speed * delta

func destroy(killed):
	if(killed):
		Globals.SCORE += score_value
		print("Score: ", Globals.SCORE)
	queue_free()

func hurt(dam):
	health -= dam
	if health <= 0:
		destroy(true)
