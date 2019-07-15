extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var slow_terrains = [0, 10, 20, 30, 7, 8, 17, 18]
var current_level = 0
var levels = ["res://UI/TitleScreen.tscn","res://maps/Map01.tscn"]

func restart_game():
	current_level = 0
	get_tree().change_scene(levels[current_level])
	
func next_level():
	current_level += 1
	if current_level < levels.size():
		get_tree().change_scene(levels[current_level])
	else:
		restart_game()
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
