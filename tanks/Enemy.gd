extends "res://tanks/Tank.gd"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var parent = get_parent()
export (float) var turret_speed
export (int) var detect_radius

var speed = 0
var target = null
# Called when the node enters the scene tree for the first time.
func _ready():
	var circle = CircleShape2D.new()
	$DetectRadius/CollisionShape2D.shape = circle
	$DetectRadius/CollisionShape2D.shape.radius = detect_radius

func control(delta):
	if parent is PathFollow2D:
		if $LookAhead1.is_colliding() or $LookAhead2.is_colliding():
			speed = lerp(speed, 0, 0.1)
		else:
			speed = lerp(speed, max_speed, 0.05)
		parent.set_offset(parent.get_offset() + speed * delta)
		position = Vector2()
	else:
		pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if target:
		var target_dir = (target.global_position - global_position).normalized()
		var current_dir = Vector2(1, 0).rotated($Turret.global_rotation)
		$Turret.global_rotation = current_dir.linear_interpolate(target_dir, turret_speed * delta).angle()
		if target_dir.dot(current_dir) > 0.95:
			shoot(gun_shots,gun_spread,target)

func _on_DetectRadius_body_entered(body):
	if body.name == "Player":
		target = body


func _on_DetectRadius_body_exited(body):
	if body == target:
		target = null
