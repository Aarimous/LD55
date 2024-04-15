extends CharacterBody2D
class_name Unit

var is_dying = false
var target : Unit


var state = Game.UNIT_STATES.WANDER
var attack_cooldown = 0


@export var max_health = 100
@export var unit_damage = 100
@export var based_damage = 100
@export var attack_speed = .5
@export var SPEED = 100
@export var WANDER_SPEED = 25
@export var avoid_distance = 100


#@export var ATTACK_KNOCKBACK = 300


var health_comp : HealthComp
var stale_check_timer = 0
var stale_check_timer_amount = 3

var entity_data : EntityData
var change_direction_timer = 0
var update_velocity = .5

func init():
	stale_check_timer = Game.rng.randf_range(0.1, .3)
	update_velocity = .1
	calc_velocity()
	cust_init()
	
	
func cust_init():
	
	pass


func state_changed():
	pass

func _physics_process(delta: float) -> void:
	if attack_cooldown > 0:
		attack_cooldown -= delta
		#move_and_slide()
	
	if change_direction_timer > 0:
		change_direction_timer -= delta
		
	if stale_check_timer > 0:
		stale_check_timer -= delta
		if stale_check_timer <= 0 and target == null:
			find_target(true)
			stale_check_timer = Game.rng.randf_range(2.5, 5.0)
			
	if update_velocity > 0:
		update_velocity -= delta
		if update_velocity <= 0:
			update_velocity = .25
			calc_velocity()

	if target != null and (is_instance_valid(target) == false or target.is_dying == true):
		find_target()
		
	
	
	match state:
		Game.UNIT_STATES.WALKING:
			var collison = move_and_collide(velocity * delta)
			if collison != null:
				var colliding_body = collison.get_collider()
				if colliding_body != null:
					target = colliding_body
					attack_target()	
					
		Game.UNIT_STATES.ATTACKING_TARGET:
			pass
		Game.UNIT_STATES.WANDER:
			move_and_slide()


func take_damage(amount):
	if health_comp != null:
		health_comp.take_damage(amount)
	else:
		push_warning("Hey you implement ", name, " is missing a health_comp")

func get_flock():
	pass

var wander_vec = Vector2.ZERO
func calc_velocity():
	var target_vec = Vector2.ZERO
	
	var avoidance_vec = Vector2.ZERO
	
	if target != null and is_instance_valid(target):	
		target_vec = (target.global_position - global_position).normalized() * SPEED
		wander_vec = Vector2.ZERO
	elif state == Game.UNIT_STATES.WANDER and change_direction_timer <= 0:
		change_direction_timer = 1.0
		
		if global_position.length() > Game.max_summon_radius:
			wander_vec = (Vector2.ZERO - global_position).normalized() * WANDER_SPEED
		else:
			wander_vec = Vector2.RIGHT.rotated(deg_to_rad(Game.rng.randf_range(0,360))) * WANDER_SPEED
		
		
		
	var flock = get_flock()
	if flock == null:
		flock = []
	avoidance_vec = get_avoidance_flock_vector(flock)

	velocity = velocity.lerp((target_vec + wander_vec + avoidance_vec).limit_length(SPEED), .33)	
	
		
func find_target(is_random = false):
	push_warning("Hey you implement a find_target function")
	
	
func attack_target():
	push_warning("Hey you implement a attack_target function")
	
	
func get_avoidance_flock_vector(flock: Array):
	var avoid_vector: = Vector2()
	
	for f in flock:
		var neighbor_pos: Vector2 = f.global_position

		var d = global_position.distance_to(neighbor_pos)
		if d > 0 and d < avoid_distance:
			avoid_vector -= (neighbor_pos - global_position).normalized() * (avoid_distance / d * SPEED)


	return avoid_vector
	
