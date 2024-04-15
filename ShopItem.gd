extends PanelContainer
class_name ShopItem

signal purchased_upgrade(shop_item : ShopItem)

@export var item_text : String = "TEXT HERE"
var cost = 0
var current_amount = 0

func _ready() -> void:
	%Label.text = item_text

func _process(delta: float) -> void:
	if Game.souls > cost:
		%Purchase.disabled = false
	else:
		%Purchase.disabled = true
		

func update_costs(new_cost, new_current_amount):
	cost = new_cost
	current_amount = new_current_amount
	%"Cost Amount".text = str(int(cost))
	%"Current Amount".text = str(new_current_amount)
	
func _on_purchase_button_up() -> void:
	AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.PURCHASE_1)
	Game.spend_souls(cost)
	purchased_upgrade.emit(self)
