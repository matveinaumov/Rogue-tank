extends CharacterBody2D

@export var speed = 500
func get_input():
	var input_dir = Input.get_vector("left","right","up","down")
