extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	for node in get_children():
		node.hide()

func update_healthbar(value):
	$HealthBar.value = value
	if value < 100:
	 $HealthBar.show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_rotation = 0
