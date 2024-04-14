extends Node


var main : Main
var based : Based

var souls = 50.0
var max_souls = 500
var souls_per_second = 1.0
var soul_pickup_range = 100
var rng : RandomNumberGenerator

var max_summon_radius = 333
var difficutly_number = 1.0


enum ENTITY_TYPES {SMALL_HUMAN, SMALL_DEVIL, MEDIUM_DEVIL, LARGE_DEVIL, TINY_DEVIL}
enum UNIT_STATES {WALKING, ATTACKING_TARGET, WANDER}


func _ready() -> void:
	rng = RandomNumberGenerator.new()
	rng.randomize()


func _process(delta: float) -> void:
	souls = clamp(souls + souls_per_second * delta, 0.0, max_souls)


func spend_souls(amount):
	souls = clamp(souls - amount, 0.0, max_souls)
	
	
func enemy_died(enemy : Enemy):
	difficutly_number += .25
	
	
func get_entity_path_by_type(type : ENTITY_TYPES):
	match type:
		ENTITY_TYPES.SMALL_HUMAN:
			return "res://Enemy.tscn"
		ENTITY_TYPES.SMALL_DEVIL:
			return "res://Player.tscn"
		ENTITY_TYPES.MEDIUM_DEVIL:
			return "res://Player.tscn"
		ENTITY_TYPES.LARGE_DEVIL:
			return "res://Player.tscn"
		ENTITY_TYPES.TINY_DEVIL:
			return "res://Player.tscn"

func get_rand_point_in_radius(radius):
	var r = radius * sqrt(randf())
	var theta : float = randf() * 2 * PI
	return Vector2(cos(theta), sin(theta)) * r
	
