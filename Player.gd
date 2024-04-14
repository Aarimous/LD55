extends Unit
class_name Player

@export var SMALL_DEVIL_ART : Texture2D
@export var MEDIUM_DEVIL_ART : Texture2D
@export var LARGE_DEVIL_ART : Texture2D
@export var TINY_DEVIL_ART : Texture2D

func _ready() -> void:
	health_comp = $HealthComp
	health_comp.init(max_health)
	
	health_comp.death_event.connect(_on_death_event)
	#velocity = Vector2.RIGHT.rotated(deg_to_rad(Game.rng.randf_range(0,360))) * SPEED
	calc_velocity()


	
func cust_init():
	match entity_data.type:
		Game.ENTITY_TYPES.SMALL_DEVIL:
			$Icon.texture = SMALL_DEVIL_ART
			$CollisionShape2D.scale = Vector2(.8, .8)
		Game.ENTITY_TYPES.MEDIUM_DEVIL:
			$Icon.texture = MEDIUM_DEVIL_ART
			$CollisionShape2D.scale = Vector2(1.4, 1.4)
		Game.ENTITY_TYPES.LARGE_DEVIL:
			$Icon.texture = LARGE_DEVIL_ART
			$CollisionShape2D.scale = Vector2(2.4, 2.4)
		Game.ENTITY_TYPES.TINY_DEVIL:
			$Icon.texture = TINY_DEVIL_ART
			$CollisionShape2D.scale = Vector2(.4, .4)
	
	health_comp.init(entity_data.max_health)		
	
func _on_death_event():
	queue_free()
	
func take_damage(amount):
	health_comp.take_damage(amount)
	
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
					
	var enemy = Game.main.get_closest_enemey(global_position)
	if enemy != null:
		target = enemy
		calc_velocity()
		state = Game.UNIT_STATES.WALKING
		
	else:
		state = Game.UNIT_STATES.WANDER
	

		
func get_flock():
	return Game.main.player_units.get_children()
		
func attack_target():
	stale_check_timer = stale_check_timer_amount
	velocity = Vector2.ZERO
	state = Game.UNIT_STATES.ATTACKING_TARGET
	
	if attack_cooldown <= 0:
		if target is Unit:
			target.take_damage(unit_damage)
		attack_cooldown = 1/attack_speed
		#velocity = (global_position - target.global_position).normalized() * ATTACK_KNOCKBACK
		var tween = create_tween()
		#tween.tween_property(self, "velocity", Vector2.ZERO, .1)
		tween.chain().tween_interval(1/attack_speed)
		tween.tween_callback(func(): state = Game.UNIT_STATES.WALKING)
		
