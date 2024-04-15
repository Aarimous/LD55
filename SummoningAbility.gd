extends PanelContainer

@export var key : String
@export var type : Game.PLAYER_ABILITY_TYPE


var cost

var is_disabled = false
var can_we_heal = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.upgrades_updated.connect(_on_upgrades_updated)
	%Key_Text.modulate = Color.GRAY
	match type:
		Game.PLAYER_ABILITY_TYPE.SUMMON_DEVIL:
			cost = Upgrades.summon_devils_cost
			%Desc.text = "Summon Devils"
		Game.PLAYER_ABILITY_TYPE.SUMMON_RITUAL:
			cost = Upgrades.summon_ritual_cost
			%Desc.text = "Summon Ritual"
		Game.PLAYER_ABILITY_TYPE.HEAL_PENTA:
			SignalBus.based_health_changed.connect(_on_based_health_changed)
			cost = Upgrades.heal_based_cost
			%Desc.text = "Heal Pentagram"
		Game.PLAYER_ABILITY_TYPE.WIN_CON:
			cost = Upgrades.win_con_cost
			%Desc.text = "Summon Lucifer"
	_on_upgrades_updated()		
			
	%Cost_Text.text = str(cost)
	%Key_Text.text = str(key)
	
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed(key):
		if Game.souls >= cost and is_disabled == false:
			match type:
				Game.PLAYER_ABILITY_TYPE.SUMMON_DEVIL:
					PlayerSummoner.start_summoning(type)
				Game.PLAYER_ABILITY_TYPE.SUMMON_RITUAL:
					PlayerSummoner.start_summoning(type)
				Game.PLAYER_ABILITY_TYPE.HEAL_PENTA:
					Game.spend_souls(cost)
					Game.based.health_comp.change_health(Upgrades.heal_pentagram_amount)
				Game.PLAYER_ABILITY_TYPE.WIN_CON:
					Game.spend_souls(cost)
					Game.main.game_over(true)

func _on_upgrades_updated():
	match type:
		Game.PLAYER_ABILITY_TYPE.SUMMON_DEVIL:
			%Desc2.text = str(Upgrades.numer_of_devils_to_summon)
		Game.PLAYER_ABILITY_TYPE.SUMMON_RITUAL:
			var rate = snapped(1/Upgrades.ritual_summon_rate, 0.1)
			%Desc2.text = str("1 Devil / ", rate , " sec")
		Game.PLAYER_ABILITY_TYPE.HEAL_PENTA:
			%Desc2.text = str(Upgrades.heal_pentagram_amount, " HP")
		Game.PLAYER_ABILITY_TYPE.WIN_CON:
			%Desc2.text = str("AKA: WIN GAME")			
			
func _on_based_health_changed(new_value, max_value):
	if new_value < max_value:
		can_we_heal = true
		set_disabled(true)
		
	else:
		can_we_heal = false
		set_disabled(false)
		
					
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	%Cost_Text.text = str(cost)
	if Game.souls < cost or can_we_heal == false:
		set_disabled(true)
	else:
		set_disabled(false)
		
		
func set_disabled(value):
	is_disabled = value
	
	if is_disabled:
		modulate = Color.DARK_GRAY
	else:
		modulate = Color.WHITE
	
