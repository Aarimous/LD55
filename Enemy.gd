extends Unit
class_name Enemy

@export var num_souls = 5
@export var souls_spawn_radius = 16

func _ready() -> void:
	health_comp = $HealthComp
	health_comp.death_event.connect(_on_death_event)
	health_comp.init(max_health)
	
func do_the_thing():
	$CollisionShape2D.disabled = false
	
func _on_death_event():
	Game.main.call_deferred("spawn_souls", num_souls, global_position, souls_spawn_radius)
	Game.enemy_died(self) 
	queue_free()
	
func find_target(is_random = false):
	if target == null or is_instance_valid(target) == false or target.is_dying == true:
		target = Game.based
		state = Game.UNIT_STATES.WALKING
	
func get_flock():
	return Game.main.enemy_units.get_children()
		
func attack_target():
	velocity = Vector2.ZERO
	state = Game.UNIT_STATES.ATTACKING_TARGET
	
	if attack_cooldown <= 0:
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
	if (is_instance_valid(body) and body is Player) or (target != null and is_instance_valid(target) and target is Based):
		target = body
		state = Game.UNIT_STATES.WALKING
