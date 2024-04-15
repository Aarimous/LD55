extends Node

@export var sound_effect_settings: Array[SoundEffectSettings]

var sound_effect_dict = {
	
}

func _ready():
	for sound_effect_setting : SoundEffectSettings in sound_effect_settings:
		sound_effect_dict[sound_effect_setting.type] = sound_effect_setting
		
	
func create_2d_audio_at_location(location, type : SoundEffectSettings.SOUND_EFFECT_TYPE):
	if sound_effect_dict.has(type):
		var sound_effect_setting : SoundEffectSettings = sound_effect_dict[type]
		if sound_effect_setting.has_open_limit():
			sound_effect_setting.change_audio_count(1)
			var new_2D_audio = AudioStreamPlayer2D.new()
			add_child(new_2D_audio)
			
			new_2D_audio.position = location
			new_2D_audio.stream = sound_effect_setting.sound_effect
			new_2D_audio.volume_db = sound_effect_setting.volume
			new_2D_audio.pitch_scale += Game.rng.randf_range(-sound_effect_setting.pitch_randomness, sound_effect_setting.pitch_randomness )
			new_2D_audio.finished.connect(sound_effect_setting.on_audio_finished)
			
			new_2D_audio.play()
	else:
		push_error("Audio Manager failed to find setting for type ", type)
