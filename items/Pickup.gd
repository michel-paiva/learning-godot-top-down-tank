extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

enum Items {health, ammo}

export (Items) var type = Items.health
export (Vector2) var amount = Vector2(10,25)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Pickup_body_entered(body):
	match type:
		Items.health:
			if body.has_method('heal'):
				body.heal(int(rand_range(amount.x, amount.y)))
		Items.ammo:
			pass
	queue_free()