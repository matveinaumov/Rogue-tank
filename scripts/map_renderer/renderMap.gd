extends TileMapLayer


@export var _Path : int = randi_range(10,20)

@export var _Size_Dunger : Vector2i = Vector2i(50,30)

@export var rooms : Array

@export var list = [
	Vector2i(0, 0), # road
	Vector2i(1, 0), # dirt
	Vector2i(2, 0), # wall
	Vector2i(3, 0)  # water
]


# ----------------------------------------------------------------------------------
class Room:
	var size_room : Vector2i
	var Way_room : Dictionary = {}
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



# ---------------------------------------------------------------------------------

func get_max(r : Array) -> int:
	var out : int
	for i in r:
		var mm = max(i.x, i.y)
		if out < mm:
			out = mm
	return out


func ADD_Rooms(r : Array):
	var pos = generate_room_positions(_Path)
	Rooms_in(pos.size())
	for i in range(pos.size()):
		for j in range(i + 1, pos.size()):
			var diff = pos[j] - pos[i]
			if diff == Vector2i.RIGHT:
				r[i].Way_room[j] = "Right"
				r[j].Way_room[i] = "Left"
			elif diff == Vector2i.LEFT:
				r[i].Way_room[j] = "Left"
				r[j].Way_room[i] = "Right"
			elif diff == Vector2i.DOWN:
				r[i].Way_room[j] = "Down"
				r[j].Way_room[i] = "Up"
			elif diff == Vector2i.UP:
				r[i].Way_room[j] = "Up"
				r[j].Way_room[i] = "Down"
	
	#for i in range(r.size()):
		#print(i, r[i].Way_room)

func Rooms_in(count : int):
	for i in range(count):
		rooms.append(Room.new(_Size_Dunger))


func generate_room_positions(count:int) -> Array:
	var positions : Array = [Vector2i.ZERO]
	var r = {Vector2i.ZERO : true}

	while positions.size() < count:
		var base = positions.pick_random()
		var dir : Vector2i
		
		match randi_range(0,3):
			0: dir = Vector2i.UP
			1: dir = Vector2i.DOWN
			2: dir = Vector2i.LEFT
			3: dir = Vector2i.RIGHT
		
		var pos = base + dir
		if pos.x < 0 or pos.y < 0:
			continue

		if r.has(pos):
			continue

		r[pos] = true
		positions.append(pos)

	return positions

func Room_Draw(room : Room) -> void:
	for y in range(room.size_room.y):
		for x in range(room.size_room.x):
			set_cell(Vector2i(x,y), 0,room.cell[y][x])

func Draw(room : Array, id : int):
	Room_Draw(room[id])


# ----------------------------------------------------------------------------------


func _ready() -> void:
	
	ADD_Rooms(rooms)
	pass
	
	
func  _process(delta: float) -> void:
	pass
