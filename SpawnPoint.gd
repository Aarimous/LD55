extends Node2D
class_name SpawnPoint

var income = 1
var budget = 0.0
var current_card : SpawnCard

@export var enemy_packed = PackedScene

var spawn_lock_out

func _ready():
	set_spawn_lockout()
	budget = Game.rng.randf_range(0.0, 5.0)

func _process(delta: float) -> void:
	income = max(1.0, Game.difficutly_number)/4.0
	budget += income * delta
	
	spawn_lock_out -= delta
	if spawn_lock_out <= 0:
		try_and_play_card()

func set_spawn_lockout():
	spawn_lock_out = Game.rng.randi_range(2.0, 5.0)	

func try_and_play_card():
	if current_card == null:
		current_card = Game.main.spawn_deck.generate_random_card()
	
	if current_card != null and budget > current_card.cost:
		for i in range(current_card.spawn_types.size()):
			var enemy_path = Game.get_entity_path_by_type(current_card.spawn_types[i])
			if enemy_path != null:
				for j in range(current_card.spawn_amounts[i]):
					spwan_enemy(enemy_packed)
			budget -= current_card.cost
			set_spawn_lockout()
			current_card = null
				

func spwan_enemy(packed_scene : PackedScene):
	if packed_scene != null:
		var new_enemy : Unit = packed_scene.instantiate()
		new_enemy.global_position = global_position + Game.get_rand_point_in_radius(32)
		Game.main.enemy_units.add_child(new_enemy)
		new_enemy.init()
		new_enemy.do_the_thing()
