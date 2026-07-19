extends Node2D
@onready var pulia_preload = preload("res://scenes/bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func piupiu():
	var pulia = pulia_preload.instantiate()
	get_tree().current_scene.add_child(pulia)  # or get_parent(), or a Bullets node
	pulia.global_position = %bullet_spawner.global_position
	pulia.global_rotation = %dulo.global_rotation
	%reload.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	
func _input(event: InputEvent) -> void:
	if(event is InputEventMouseButton and event.is_pressed() and %reload.time_left ==0.0):
		piupiu()
