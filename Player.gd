extends Unit
class_name Player

var max_distance = 666.0
var starting_speed
var starting_wander 
var starting_attack_speed

func _ready() -> void:
	
	SignalBus.upgrades_updated.connect(_on_upgrades_updated)
	health_comp = $HealthComp
	
	_on_upgrades_updated()
	health_comp.init(max_health)
	
	health_comp.death_event.connect(_on_death_event)
	
	#velocity = Vector2.RIGHT.rotated(deg_to_rad(Game.rng.randf_range(0,360))) * SPEED
	calc_velocity()
	
func cust_init():
	
	match Game.rng.randi_range(0, 5):
		0:
			AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.DEVIL_HUZZAH)
		1:
			AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.DEVIL_AYO)
		2:
			AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.DEVIL_HUH)
		3:
			AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.DEVIL_IM_READY)
		4:
			AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.DEVIL_LETS_GO_GET_EM)
		5:
			AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.DEVIL_FOR_LUCIFER)


func _on_upgrades_updated():
	max_health = Upgrades.devil_health
	health_comp.max_health = max_health
	
	unit_damage = Upgrades.devil_damage
	attack_speed = Upgrades.devil_attack_speed
	SPEED = Upgrades.devil_speed
	WANDER_SPEED = SPEED/2.0
	
	starting_speed = SPEED
	starting_wander = WANDER_SPEED
	starting_attack_speed = attack_speed
		
	
func _on_death_event():
	match Game.rng.randi_range(0, 5):
		0:
			AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.DEVIL_DIE_1)
		1:
			AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.DEVIL_DIE_2)
		2:
			AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.DEVIL_DIE_3)
		3:
			AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.DEVIL_DIE_4)
	
	queue_free()
	
func take_damage(amount):
	health_comp.take_damage(amount)
	
	match Game.rng.randi_range(0, 4):
		0:
			AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.DEVIL_GRUNT_1)
		1:
			AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.DEVIL_GRUNT_2)
		2:
			AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.DEVIL_GRUNT_3)
	
func find_target(is_random = false):
	#var enemies_in_range = $"Agro Range".get_overlapping_bodies()
	#if enemies_in_range.size() > 0:
		#if is_random == true:
			#target = enemies_in_range.pick_random()
		#else:
			#var min_distance
			#for enemy in enemies_in_range:
				#var dist_check = global_position.distance_to(enemy.global_position)
				#if min_distance == null or dist_check < min_distance:
					#min_distance = dist_check
					#target = enemy	
					
	var enemy = Game.main.get_closest_enemey(global_position, max_distance)
	if enemy != null:
		target = enemy
		calc_velocity()
		state = Game.UNIT_STATES.WALKING
		%AnimationPlayer.play("Walk")
		%AnimationPlayer.speed_scale = float(SPEED)/float(starting_speed)
		
	
	else:
		state = Game.UNIT_STATES.WANDER
		%AnimationPlayer.play("Walk")
		%AnimationPlayer.speed_scale = float(SPEED)/float(starting_speed)
		
func get_flock():
	return Game.main.player_units.get_children()
		
func attack_target():
	
	%AnimationPlayer.play("Attack")
	%AnimationPlayer.speed_scale = float(attack_speed)/float(starting_attack_speed)
	
	var angle = global_position.angle_to_point(target.global_position)
	$"Art Pivot/PitchForkPivot".rotation = angle + deg_to_rad(45)
	
	stale_check_timer = stale_check_timer_amount
	velocity = Vector2.ZERO
	state = Game.UNIT_STATES.ATTACKING_TARGET
	
	

	
	if attack_cooldown <= 0:
		match Game.rng.randi_range(0, 8):
			0:
				AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.DEVIL_ATK_1)
			1:
				AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.DEVIL_ATK_2)
			2:
				AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.DEVIL_ATK_3)
			3:
				AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.DEVIL_ATK_4)
			4:
				AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.DEVIL_ATK_5)
			5:
				AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.DEVIL_ATK_6)

		
		if target is Unit:
			target.take_damage(unit_damage)
		attack_cooldown = 1/attack_speed
		#velocity = (global_position - target.global_position).normalized() * ATTACK_KNOCKBACK
		var tween = create_tween()
		#tween.tween_property(self, "velocity", Vector2.ZERO, .1)
		tween.chain().tween_interval(1/attack_speed)
		tween.tween_callback(func(): state = Game.UNIT_STATES.WALKING)
		
