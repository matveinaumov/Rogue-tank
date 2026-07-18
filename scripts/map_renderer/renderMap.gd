extends TileMapLayer


@export var width = 50
@export var height = 30





var list = [
	Vector2i(0, 0), # road
	Vector2i(1, 0), # dirt
	Vector2i(2, 0), # wall
	Vector2i(3, 0)  # water
]


func _ready() -> void:
	for y in range(height):
		for x in range(width):
			set_cell(Vector2(x,y), 0, list[0])
			if randf() < 0.1:
				set_cell(Vector2(x,y), 0, list[2])
			if randf() < 0.1:
				set_cell(Vector2(x,y), 0, list[1])
			if randf() < 0.1:
				set_cell(Vector2(x,y), 0, list[3])
	pass 


func _process(delta: float) -> void:
	pass
