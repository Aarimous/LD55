extends Node2D

var state = SUMMONING_STATES.FREE
enum SUMMONING_STATES {FREE, SUMMONING}

@export var summoning_cursor : Texture2D
@export var player_unit_packed : PackedScene
@export var ritual_pack : PackedScene

@onready var summoner_icon: Sprite2D = %SummonerIcon

var type_to_summon

var current_entity_data : EntityData
func _ready():
	summoner_icon.visible = false

func start_summoning(_type_to_summon : Game.PLAYER_ABILITY_TYPE):
	summoner_icon.visible = true
	type_to_summon = _type_to_summon
	state = SUMMONING_STATES.SUMMONING
	#Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	
func _process(delta: float) -> void:
	summoner_icon.global_position = get_global_mouse_position().limit_length(Game.max_summon_radius)
	

func _input(event: InputEvent) -> void:
	if state == SUMMONING_STATES.SUMMONING:
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed == false:
			if type_to_summon != null:
				match type_to_summon:
					Game.PLAYER_ABILITY_TYPE.SUMMON_DEVIL:
						summon_devils()
					Game.PLAYER_ABILITY_TYPE.SUMMON_RITUAL:
						summon_ritual()
			
func summon_devils():
	if Game.souls > Upgrades.summon_devils_cost:
		Game.spend_souls(Upgrades.summon_devils_cost)
		for i in range(Upgrades.numer_of_devils_to_summon):
			var new_unit : Unit = player_unit_packed.instantiate()
			Game.main.player_units.add_child(new_unit)
			new_unit.global_position = summoner_icon.global_position + Game.get_rand_point_in_radius(i * 5)
			new_unit.init()
			stop_summoning()

func summon_ritual():
	if Game.souls > Upgrades.summon_ritual_cost:
		Game.spend_souls(Upgrades.summon_ritual_cost)
		var new_ritual = ritual_pack.instantiate()
		Game.main.add_child(new_ritual)
		new_ritual.global_position = summoner_icon.global_position
		stop_summoning()


func stop_summoning():
	type_to_summon = null
	state = SUMMONING_STATES.FREE
	summoner_icon.visible = false
