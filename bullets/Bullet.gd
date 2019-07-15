extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (int) var speed
export (int) var damage
export (float) var lifetime
export (float) var steer_force = 0

var velocity = Vector2()
var acceleration = Vector2()
var target = null
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func start(_position, _direction, _target=null):
	position = _position
	rotation = _direction.angle()
	$Lifetime.wait_time = lifetime
	velocity = _direction * speed
	target = _target
	$Lifetime.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if target:
		acceleration += seek()
		velocity += acceleration * delta
		velocity.clamped(speed)
		rotation = velocity.angle()
	position += velocity * delta

func seek():
	var desired = (target.position-position).normalized() * speed
	var steer = (desired - velocity).normalized() * steer_force
	return steer

func explode():
	velocity = Vector2()
	$Sprite.hide()
	$Explosion.show()
	$Explosion.play("smoke")

func _on_Bullet_body_entered(body):
	explode()
	if body.has_method('take_damage'):
		body.take_damage(damage)

func _on_Lifetime_timeout():
	explode()


func _on_Explosion_animation_finished():
	queue_free()
