extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var tile_size = Vector2(128, 128)
onready var texture = $Sprite.texture

# Called when the node enters the scene tree for the first time.
func _ready():
	var texture_width = texture.get_width() / tile_size.x
	var texture_height = texture.get_height() / tile_size.y
	var ts = TileSet.new()
	for x in range(texture_width):
		for y in range(texture_height):
			var region = Rect2(x * tile_size.x, y * tile_size.y,
								tile_size.x, tile_size.y)
			var id = x + y * 10;
			ts.create_tile(id)
			ts.tile_set_texture(id, texture)
			ts.tile_set_region(id, region)
	ResourceSaver.save("res://terrain/TerrainTile.tres", ts)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
