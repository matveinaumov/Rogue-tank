extends TileMapLayer


@export var _Path : int = 5

@export var _Size_Dunger : Vector2i = Vector2i(50,30)

@export var rooms : Array = []

@export var list = [
	Vector2i(0, 0), # road
	Vector2i(1, 0), # dirt
	Vector2i(2, 0), # wall
	Vector2i(3, 0)  # water
]
class Room:
	var size_room : Vector2i
	var Way_room : Array[String]
	var cell : Array
	
	func _init(s: Vector2i):
		size_room = s
		_intz_cell()

	func _intz_cell() -> void:
		for y in range(size_room.y):
			cell.append([])
			for x in range(size_room.x):
				if y == 0 or y == size_room.y-1:
					cell[y].append(Vector2(2,0))
				elif x == 0 or x == size_room.x-1:
					cell[y].append(Vector2(2,0))
				else:
					cell[y].append(Vector2(0,0))


	


func Draw(room : Room) -> void:
	for y in range(room.size_room.y):
		for x in range(room.size_room.x):
			set_cell(Vector2i(x,y), 0,room.cell[y][x])

func _Rooms() -> void:
	for i in range(_Path):
		rooms.append(Room.new(_Size_Dunger))


func _ready() -> void:
	_Rooms()
	Draw(rooms[0])
	pass
	
	
func  _process(delta: float) -> void:
	pass
