extends Node2D
class_name Main


@onready var player_units: Node2D = $"Player Units"
@onready var enemy_units: Node2D = %"Enemy Units"



@export var soul_packed : PackedScene

@export var spawn_deck : SpawnDeck


func _input(event: InputEvent) -> void:
	if event.is_action_released("ui_cancel"):
		get_tree().quit()
		


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Game.main = self

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func spawn_souls(num_souls, glob_pos, spawn_range):
	for i in range(num_souls):
		var new_soul = soul_packed.instantiate()
		add_child(new_soul)
		new_soul.global_position = glob_pos + Game.get_rand_point_in_radius(spawn_range)
	
	
func get_closest_enemey(from_global_position : Vector2):
	var target
	var min_distance
	for enemy in enemy_units.get_children():
		var dist_check = from_global_position.distance_to(enemy.global_position)
		if min_distance == null or dist_check < min_distance:
			min_distance = dist_check
			target = enemy
			
	return target
