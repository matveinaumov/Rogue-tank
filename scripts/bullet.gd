extends CharacterBody2D
@export var speed = 155

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	look_at(get_global_mouse_position())
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#velocity.x += speed*delta
	#velocity.y += speed*delta
	position += transform.x *speed *delta
	move_and_slide()


func _on_timer_timeout() -> void:
	queue_free()
