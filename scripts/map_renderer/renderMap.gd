extends TileMapLayer


@export var width = 50
@export var height = 30


var ground_tile = Vector2i(0, 0)
var wall_tile = Vector2i(1, 0)


func _ready() -> void:
	for y in range(height):
		for x in range(width):
			set_cell(Vector2(x,y), 0, wall_tile)
			if randf() < 0.1:
				set_cell(Vector2(x,y), 0, ground_tile)
	pass 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
