extends Node2D
class_name Main


@onready var player_units: Node2D = $"Player Units"
@onready var enemy_units: Node2D = %"Enemy Units"



@export var soul_packed : PackedScene

@export var spawn_deck : SpawnDeck


#func _input(event: InputEvent) -> void:
	#if event.is_action_released("ui_cancel"):
		#get_tree().quit()

func game_over(is_win : bool):
	Game.is_game_over = true
	%ShopTimer.stop()
	%Shop.visible = false
	if is_win == true:
		%"Game Over Text".text = "VICTORY"
		
	else:
		%"Game Over Text".text = "DEFEAT"
		
	%"Game Over Screen".visible = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Game.main = self
	%Shop.visible = false
	%"Game Over Screen".visible = false
	

	%ShopTimer.start(10)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func spawn_souls(num_souls, glob_pos, spawn_range):
	for i in range(Upgrades.enemy_blood_dropped):
		var new_soul = soul_packed.instantiate()
		add_child(new_soul)
		new_soul.global_position = glob_pos + Game.get_rand_point_in_radius(spawn_range)
	
	
func get_closest_enemey(from_global_position : Vector2, max_distace):
	var target
	var min_distance
	for enemy in enemy_units.get_children():
		var dist_check = from_global_position.distance_to(enemy.global_position)
		if dist_check < max_distace and (min_distance == null or dist_check < min_distance):
			min_distance = dist_check
			target = enemy
			
	return target

func _on_shop_timer_timeout() -> void:

	
	match Game.rng.randi_range(0, 6):
		0:
			AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.SHOP_OPEN_1)
		1:
			AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.SHOP_OPEN_2)
		2:
			AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.SHOP_OPEN_3)
		3:
			AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.SHOP_OPEN_4)
		4:
			AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.SHOP_OPEN_5)
		5:
			AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.SHOP_OPEN_6)
		6:
			AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.SHOP_OPEN_7)
	
	Game.difficutly_number += 0.67
	get_tree().paused = true
	%Shop.visible = true


func _on_shop_close_shop() -> void:
	get_tree().paused = false
	
	%Shop.visible = false
	
	%ShopTimer.start(30)
	
	SignalBus.upgrades_updated.emit()
	
	match Game.rng.randi_range(0, 5):
		0:
			AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.SHOP_CLOSE_1)
		1:
			AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.SHOP_CLOSE_2)
		2:
			AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.SHOP_CLOSE_3)
		3:
			AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.SHOP_CLOSE_4)
		4:
			AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.SHOP_CLOSE_5)
		5:
			AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.SHOP_CLOSE_6)
	
