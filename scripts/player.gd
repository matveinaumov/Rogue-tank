extends CharacterBody2D

@export var speed = 100
@export var rot_speed = 3
@export var rot_dir = 0

func _physics_process(delta: float) -> void:
	rot_dir = Input.get_axis("left","right")
	velocity = transform.x * Input.get_axis("down","up") *speed
	if velocity:
		%AnimatedSprite2D.play("drive")
	else:
		%AnimatedSprite2D.stop()
	rotation += rot_dir*rot_speed*delta
	move_and_slide()
