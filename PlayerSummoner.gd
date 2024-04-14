extends Node2D

var state = SUMMONING_STATES.FREE
enum SUMMONING_STATES {FREE, SUMMONING}

@export var summoning_cursor : Texture2D
@export var player_unit_packed : PackedScene

@onready var summoner_icon: Sprite2D = %SummonerIcon

var current_entity_data : EntityData
func _ready():
	summoner_icon.visible = false

func start_summoning(entity_data):
	summoner_icon.visible = true
	state = SUMMONING_STATES.SUMMONING
	current_entity_data = entity_data
	#Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	


func _process(delta: float) -> void:
	summoner_icon.global_position = get_global_mouse_position().limit_length(Game.max_summon_radius)
	

func _input(event: InputEvent) -> void:
	if state == SUMMONING_STATES.SUMMONING:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT:
				if event.pressed == false:
					if current_entity_data != null:
						if Game.souls > current_entity_data.soul_cost:
							
							#var entity_path = Game.get_entity_path_by_type(current_entity_data.type)
							#if entity_path != null:
							Game.spend_souls(current_entity_data.soul_cost)
							for i in range(current_entity_data.spawn_amount):
								var new_unit : Unit = player_unit_packed.instantiate()
								Game.main.player_units.add_child(new_unit)
								new_unit.global_position = summoner_icon.global_position + Game.get_rand_point_in_radius(50)
								new_unit.init(current_entity_data)
								stop_summoning()
	
func stop_summoning():
	state = SUMMONING_STATES.FREE
	#current_entity_data = null
	#Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	summoner_icon.visible = false
