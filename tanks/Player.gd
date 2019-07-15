extends "res://tanks/Tank.gd"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func control(delta):
	$Turret.look_at(get_global_mouse_position())
	var rot_dir = 0
	if Input.is_action_pressed("rotate_left"):
		rot_dir -= 1
	if Input.is_action_pressed("rotate_right"):
		rot_dir += 1
	rotation += rotation_speed * rot_dir * delta
	velocity = Vector2()
	if Input.is_action_pressed("forward"):
		velocity = Vector2(max_speed, 0).rotated(rotation)
	if Input.is_action_pressed("backward"):
		velocity = Vector2(-max_speed/2, 0).rotated(rotation)
	if Input.is_action_just_pressed("mouse_click"):
		shoot(gun_shots, gun_spread)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
