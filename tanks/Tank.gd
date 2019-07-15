extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal shoot
signal health_changed
signal dead

export (PackedScene) var Bullet
export (int) var max_speed
export (float) var rotation_speed
export (float) var gun_cooldown
export (int) var max_health
export (float) var offroad_friction
export (int) var gun_shots = 1
export (float, 0, 1.5) var gun_spread = 0.2 

var velocity = Vector2()
var can_shoot = true
var alive = true
var health = 100
var map

# Called when the node enters the scene tree for the first time.
func _ready():
	health = max_health
	emit_signal("health_changed", float(health) / max_health * 100)
	$GunTimer.wait_time = gun_cooldown
	
func control(delta):
	pass

func shoot(number_of_bullets,spread_of_bullets,target=null):
	if can_shoot:
		can_shoot = false
		$GunTimer.start()
		var dir = Vector2(1, 0).rotated($Turret.global_rotation)
		if number_of_bullets > 1:
			for i in range(number_of_bullets):
				var angle = -spread_of_bullets + i * (2*spread_of_bullets)/(number_of_bullets-1)
				emit_signal("shoot", Bullet, $Turret/Muzzle.global_position, dir.rotated(angle), target)
		else:
			emit_signal("shoot", Bullet, $Turret/Muzzle.global_position, dir, target)
			$AnimationPlayer.play("muzzle_flash")

func take_damage(amount):
	health -= amount
	emit_signal("health_changed", float(health)/max_health * 100)
	if health < max_health / 3:
		$Smoke.visible = true
		$Smoke.emitting = true
	if health <= 0:
		explode()

func heal(amount):
	health += amount
	health = clamp(health,0, max_health)
	emit_signal("health_changed", float(health)/max_health * 100)
	if health >= max_health / 3:
		$Smoke.visible = false
		$Smoke.emitting = false
	
func explode():
	$CollisionShape2D.disabled = true
	alive = false
	$Turret.hide()
	$Body.hide()
	$Explosion.show()
	$Explosion.play()
	emit_signal("dead")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not alive:
		return
	control(delta)
	if map:
		var tile = map.get_cellv(map.world_to_map(position))
		if tile in GLOBALS.slow_terrains:
			velocity *= offroad_friction
	move_and_slide(velocity)
	
func _on_GunTimer_timeout():
	can_shoot = true


func _on_Explosion_animation_finished():
	queue_free()
