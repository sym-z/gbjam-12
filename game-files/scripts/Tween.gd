extends Control
# Code inspired from https://www.gotut.net/tweens-in-godot-4/
@export var tex : TextureRect
var tween : Tween
enum AIM {NORTH, SOUTH, EAST, WEST}
@export var dur : float = 0.1
@export var offset : int = 10
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func shake(direction):
	match direction:
		AIM.NORTH:
			tween = create_tween()
			tween.tween_property(tex, "position:y", offset, dur)
			tween.tween_property(tex, "position:y", 0, dur)
			pass
		AIM.SOUTH:
			tween = create_tween()
			tween.tween_property(tex, "position:y", -offset, dur)
			tween.tween_property(tex, "position:y", 0, dur)
			pass
		AIM.EAST:
			tween = create_tween()
			tween.tween_property(tex, "position:x", -offset, dur)
			tween.tween_property(tex, "position:x", 0, dur)
			pass
		AIM.WEST:
			tween = create_tween()
			tween.tween_property(tex, "position:x", offset, dur)
			tween.tween_property(tex, "position:x", 0, dur)
			pass
