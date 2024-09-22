### USED FOR MAIN MENU ***
extends Control
var change = false

func _ready():
	pass 

func _process(_delta):
	if !change:
		change = true
		get_tree().change_scene_to_file("res://scenes/level_one.tscn")
	pass
