extends Node2D
class_name SpawnPoint

var income = 1
var budget = 0.0
var current_card : SpawnCard

@export var enemy_packed = PackedScene

func _ready():
	budget = Game.rng.randf_range(-5.0, 10.0)

func _process(delta: float) -> void:
	income = Game.difficutly_number / 3.0
	budget += income * delta
	try_and_play_card()
	

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
			current_card = null
				

func spwan_enemy(packed_scene : PackedScene):
	if packed_scene != null:
		var new_enemy : Unit = packed_scene.instantiate()
		new_enemy.global_position = global_position + Game.get_rand_point_in_radius(100)
		Game.main.enemy_units.add_child(new_enemy)
		
		new_enemy.do_the_thing()
