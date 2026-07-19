extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	texture = load("res://assets/textures/tank.png")
	region_enabled = true
	region_rect = Rect2(0, 16, 16, 16)
	rotation_degrees = 90


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
