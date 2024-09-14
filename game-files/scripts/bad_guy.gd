extends Node2D
@export var speed : int = 5
@export var direction : Vector2 = Vector2.ZERO
@export var damage : int = 1
@export var health : int = 1
func _ready():
	pass 

func _process(delta):
	move(delta)

func move(delta):
	position += (speed * direction) * delta

func destroy():
	queue_free()

func hurt(damage):
	health -= damage
	if health <= 0:
		destroy()
