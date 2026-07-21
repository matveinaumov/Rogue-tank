extends TileMapLayer


@export var _Path : int = randi_range(5,10)

@export var _Size_Dunger : Vector2i = Vector2i(50,30)
@export var player: Node2D

@export var rooms : Array
@export var current_room : int = 0

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
	var setup : bool = false
	
	func SetUp() -> void:
		if setup: return
		for i in Way_room:
			if Way_room[i] == "Right":
				for y in range(size_room.y/2-1, size_room.y/2+1):
					cell[y][size_room.x-1] = Vector2i(3,0) 
			elif Way_room[i] == "Left":
				for y in range(size_room.y/2-1, size_room.y/2+1):
					cell[y][0] = Vector2i(3,0) 
			elif Way_room[i] == "Up":
				for x in range(size_room.x/2-1, size_room.x/2+1):
					cell[0][x] = Vector2i(3,0) 
			elif Way_room[i] == "Down":
				for x in range(size_room.x/2-1,size_room.x/2+1):
					cell[size_room.y-1][x] = Vector2i(3,0) 

		
		
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
	
	func End() -> void:
		cell[10][10] = Vector2i(3,0)



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
	
	for i in range(r.size()):
		print(i, r[i].Way_room)
	r[r.size()-1].End()

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

func Draw(room : Array):
	room[current_room].SetUp()
	Room_Draw(room[current_room])


# ----------------------------------------------------------------------------------
func St():
	var start = Label.new()
	start.text = "Start"
	start.position = map_to_local(Vector2i(25, 15))
	add_child(start)

func Ed():
	var ed = Label.new()
	ed.text = "End"
	ed.position = map_to_local(Vector2i(25, 15))
	add_child(ed)


func _ready() -> void:
	
	
	if (current_room == 0):
		St()
	elif current_room == rooms.size()-1:
		Ed()
	var player = get_parent().get_node("Player")
	player.position = map_to_local(Vector2i(25,15))
	ADD_Rooms(rooms)
	Draw(rooms)
	pass
	
	
func  _process(delta: float) -> void:
	
	pass
