extends Control

@export var show_time = 1.0
@export var show_duration = 10.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	show_time -= delta
	
	if show_time <= 0:
		visible = true
		
		show_duration -= delta
		if show_duration <= 0.0:
			queue_free()

	else:
		visible = false
