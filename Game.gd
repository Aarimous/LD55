extends Node


var main : Main
var based : Based

var souls = 125.0
var max_souls = 666
var souls_per_second = 1.5
var soul_pickup_range = 66.6
var rng : RandomNumberGenerator

enum PLAYER_ABILITY_TYPE {SUMMON_DEVIL, SUMMON_RITUAL, HEAL_PENTA, WIN_CON}

var max_summon_radius = 166

var difficutly_number = 0.0



enum ENTITY_TYPES {SMALL_HUMAN, SUMMON_DEVILS}

enum UNIT_STATES {WALKING, ATTACKING_TARGET, WANDER}


var is_game_over = false

func _ready() -> void:
	rng = RandomNumberGenerator.new()
	rng.randomize()


func _process(delta: float) -> void:
	souls = clamp(souls + Upgrades.blood_gained_per_second * delta, 0.0, max_souls)

func spend_souls(amount):
	souls = clamp(souls - amount, 0.0, max_souls)
	
	
func enemy_died(enemy : Enemy):
	pass
	#difficutly_number += .25
	
	
func get_entity_path_by_type(type : ENTITY_TYPES):
	match type:
		ENTITY_TYPES.SMALL_HUMAN:
			return "res://Enemy.tscn"
		ENTITY_TYPES.SUMMON_DEVILS:
			return "res://Player.tscn"

func get_rand_point_in_radius(radius):
	var r = radius * sqrt(randf())
	var theta : float = randf() * 2 * PI
	return Vector2(cos(theta), sin(theta)) * r
	

	
