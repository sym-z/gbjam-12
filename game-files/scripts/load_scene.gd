extends Node2D
var change = false
# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if !change:
		change = true
		get_tree().change_scene_to_file("res://scenes/start_scene.tscn")
	pass
