extends Node2D
@export var player : Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	### CENTER PLAYER ###
	player.position.y = get_viewport_rect().size.y / 2
	player.position.x = get_viewport_rect().size.x / 2
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
