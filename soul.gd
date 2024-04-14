extends Node2D

var has_been_collected = false

func get_collected():
	has_been_collected = true
	Game.souls += 1
	queue_free()

func _physics_process(delta: float) -> void:
	if has_been_collected == false:
		if global_position.distance_to(get_global_mouse_position()) <= Game.soul_pickup_range:
			get_collected()
