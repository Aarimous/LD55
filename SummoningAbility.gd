extends PanelContainer

@export var key : String
@export var entity_data : EntityData

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%Cost_Text.text = str(entity_data.soul_cost)
	%Key_Text.text = str(key)
	
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed(key):
		if Game.souls > entity_data.soul_cost:
			PlayerSummoner.start_summoning(entity_data)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	%Cost_Text.text = str(entity_data.soul_cost)
	if entity_data.soul_cost > Game.souls:
		modulate = Color.GRAY
	else:
		modulate = Color.WHITE
