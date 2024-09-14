extends Node2D
@export var speed : int = 0
@export var direction : Vector2 = Vector2.ZERO

func _ready():
	pass 

func _process(delta):
	move(delta)

func move(delta):
	position += (speed * direction) * delta
