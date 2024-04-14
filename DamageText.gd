extends Label


# Called when the node enters the scene tree for the first time.
func init() -> void:
	var tween = create_tween().set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "global_position:y", global_position.y - 50, .5)
	tween.tween_property(self, "modulate:a", 0, .33)
