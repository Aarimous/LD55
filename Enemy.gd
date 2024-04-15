extends Unit
class_name Enemy

@export var num_souls = 5
@export var souls_spawn_radius = 8

func _ready() -> void:
	health_comp = $HealthComp
	health_comp.death_event.connect(_on_death_event)
	health_comp.init(max_health)
	
func cust_init():
	match Game.rng.randi_range(0, 5):
		0:
			AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.ANGEL_SUMMON_1)
		1:
			AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.ANGEL_SUMMON_2)
		2:
			AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.ANGEL_SUMMON_3)
		3:
			AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.ANGEL_SUMMON_4)
		4:
			AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.ANGEL_SUMMON_5)
		5:
			AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.ANGEL_SUMMON_6)

func take_damage(amount):
	match Game.rng.randi_range(0, 8):
		0:
			AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.ANGEL_TAKE_DAMAGE_1)
		1:
			AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.ANGEL_TAKE_DAMAGE_2)
		2:
			AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.ANGEL_TAKE_DAMAGE_3)
		3:
			AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.ANGEL_TAKE_DAMAGE_4)
		4:
			AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.ANGEL_TAKE_DAMAGE_5)

	
	if health_comp != null:
		health_comp.take_damage(amount)

func do_the_thing():
	$CollisionShape2D.disabled = false
	
func _on_death_event():
	Game.main.call_deferred("spawn_souls", num_souls, global_position, souls_spawn_radius)
	Game.enemy_died(self) 
	queue_free()
	
func find_target(is_random = false):
	if target == null or is_instance_valid(target) == false or target.is_dying == true:
		var min_distance
		target = null
		for players in $AgroRange.get_overlapping_bodies():
			var dist_check = global_position.distance_to(players.global_position)
			if min_distance == null or dist_check < min_distance:
				min_distance = dist_check
				target = players
				state = Game.UNIT_STATES.WALKING
				%AnimationPlayer.play("Walk")
				
		if target == null:
			target = Game.based
			state = Game.UNIT_STATES.WALKING
			%AnimationPlayer.play("Walk")
		
func get_flock():
	return Game.main.enemy_units.get_children()
		
func attack_target():

	%AnimationPlayer.play("Attack")
	
	var angle = global_position.angle_to_point(target.global_position)
	%SwordPivot.rotation = angle
	
	velocity = Vector2.ZERO
	state = Game.UNIT_STATES.ATTACKING_TARGET
	
	
	
	
	if attack_cooldown <= 0:
		match Game.rng.randi_range(0, 10):
			0:
				AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.ANGEL_ATK_1)
			1:
				AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.ANGEL_ATK_2)
			2:
				AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.ANGEL_ATK_3)
			3:
				AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.ANGEL_ATK_4)
			4:
				AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.ANGEL_ATK_5)
			5:
				AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.ANGEL_ATK_6)
			6:
				AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.ANGEL_ATK_7)

		
		
		
		if target is Unit:
			target.take_damage(unit_damage)
		elif target is Based:
			target.take_damage(based_damage)
			
		attack_cooldown = 1/attack_speed
		#velocity = (global_position - target.global_position).normalized() * ATTACK_KNOCKBACK
		var tween = create_tween()
		#tween.tween_property(self, "velocity", Vector2.ZERO, .1)
		tween.chain().tween_interval(1/attack_speed)
		tween.tween_callback(func(): state = Game.UNIT_STATES.WALKING)


func _on_agro_range_body_entered(body: Node2D) -> void:
	#If current traget is the base we will switch
	if target != null and is_instance_valid(target) and target is Based:
		target = body
		state = Game.UNIT_STATES.WALKING
	
	#if our current traget is already a player we will do nothing
	
	
	
	
	#if (target == null and is_instance_valid(body) and body is Player) or (target != null and is_instance_valid(target) and target is Based):
		#target = body
		#state = Game.UNIT_STATES.WALKING
