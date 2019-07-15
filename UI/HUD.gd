extends CanvasLayer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func update_healthbar(value):
	$Margin/Container/HealthBar/Tween.interpolate_property(
		$Margin/Container/HealthBar,
		'value',
		$Margin/Container/HealthBar.value,
		value,
		0.2,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN_OUT)
	$Margin/Container/HealthBar/Tween.start()
	$AnimationPlayer.play("healthbar_flash")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
