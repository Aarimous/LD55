extends Node2D

var has_been_collected = false

func get_collected():
	has_been_collected = true
	Game.souls += 1
	
	AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.SOULS_SUCK_1)
	
	look_at(Vector2.ZERO)
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1.1, 1.1), .1).set_ease(Tween.EASE_IN)
	tween.tween_property(self, "scale", Vector2(1.5, .3), .2).set_ease(Tween.EASE_IN)
	tween.chain().tween_property(self, "global_position", Vector2.ZERO, .3).set_ease(Tween.EASE_IN)
	tween.tween_callback(queue_free)
	
	

func _physics_process(delta: float) -> void:
	if has_been_collected == false:
		if global_position.distance_to(get_global_mouse_position()) <= Game.soul_pickup_range:
			get_collected()
