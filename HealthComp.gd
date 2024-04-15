extends Node
class_name HealthComp


@export var max_health : float = 100.0
@export var current_health  : float = 0.0
@export var health_regen_per_second = 0.0

signal death_event()
signal health_changed(new_value, max_value)

func _ready():
	pass
	#current_health = max_health
		
func init(_max_health):
	max_health = _max_health
	current_health = max_health


	
	
func take_damage(damage_amount):
	change_health(-damage_amount)
	DamageTextHandler.create_damage_text(damage_amount, get_parent().global_position)
	
func change_health(amount):
	var new_health =  clamp(current_health + amount, 0.0, max_health)
	
	if new_health != current_health:
		health_changed.emit(new_health, max_health)
		
	current_health = new_health
	
	if current_health <= 0:
		die()	

func die():
	death_event.emit()
