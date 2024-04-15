extends PanelContainer

signal close_shop

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%"Summon more Devils".update_costs(Upgrades.numer_of_devils_to_summon_cost, Upgrades.numer_of_devils_to_summon)
	%"Devil Damage".update_costs(Upgrades.devil_damage_cost, Upgrades.devil_damage)
	%"Devil Heal".update_costs(Upgrades.devil_health_cost, Upgrades.devil_health) 
	%"Devil Speed".update_costs(Upgrades.devil_speed_cost, Upgrades.devil_speed) 
	%"Devil Attack Speed".update_costs(Upgrades.devil_attack_speed_cost, Upgrades.devil_attack_speed)
	%"Ritual Summon Rate".update_costs(Upgrades.ritual_summon_rate_cost, Upgrades.ritual_summon_rate)
	%"Ritual Duration".update_costs(Upgrades.ritual_duration_cost, Upgrades.ritual_duration) 
	%"Heal Pentagram Amount".update_costs(Upgrades.heal_pentagram_amount_cost, Upgrades.heal_pentagram_amount)
	%"Blood Gained Per Second".update_costs(Upgrades.blood_gained_per_second_cost, Upgrades.blood_gained_per_second)
	%"Enemy Blood Dropped".update_costs(Upgrades.enemy_blood_dropped_cost, Upgrades.enemy_blood_dropped)


func _on_close_shop_button_up() -> void:
	close_shop.emit()


func _on_summon_more_devils_purchased_upgrade(shop_item: ShopItem) -> void:
	Upgrades.numer_of_devils_to_summon += 1
	shop_item.update_costs(shop_item.cost + Upgrades.numer_of_devils_to_summon_cost_increase, Upgrades.numer_of_devils_to_summon)


func _on_devil_damage_purchased_upgrade(shop_item: ShopItem) -> void:
	Upgrades.devil_damage += 5
	shop_item.update_costs(shop_item.cost + Upgrades.devil_damage_cost_increase, Upgrades.devil_damage)


func _on_devil_heal_purchased_upgrade(shop_item: ShopItem) -> void:
	Upgrades.devil_health += 5
	shop_item.update_costs(shop_item.cost + Upgrades.devil_health_cost_increase, Upgrades.devil_health)


func _on_devil_speed_purchased_upgrade(shop_item: ShopItem) -> void:
	Upgrades.devil_speed += 10
	shop_item.update_costs(shop_item.cost + Upgrades.devil_attack_speed_cost_increase, Upgrades.devil_speed)


func _on_devil_attack_speed_purchased_upgrade(shop_item: ShopItem) -> void:
	Upgrades.devil_attack_speed += .25
	shop_item.update_costs(shop_item.cost + Upgrades.devil_attack_speed_cost_increase, Upgrades.devil_attack_speed)


func _on_ritual_duration_purchased_upgrade(shop_item: ShopItem) -> void:
	Upgrades.ritual_duration += 5
	shop_item.update_costs(shop_item.cost + Upgrades.ritual_duration_cost_increase, Upgrades.ritual_duration)



func _on_heal_pentagram_amount_purchased_upgrade(shop_item: ShopItem) -> void:
	Upgrades.heal_pentagram_amount += 25
	shop_item.update_costs(shop_item.cost + Upgrades.heal_pentagram_amount_cost_increase, Upgrades.heal_pentagram_amount)


func _on_blood_gained_per_second_purchased_upgrade(shop_item: ShopItem) -> void:
	Upgrades.blood_gained_per_second += 1.0
	shop_item.update_costs(shop_item.cost + Upgrades.blood_gained_per_second_cost_increase, Upgrades.blood_gained_per_second)


func _on_ritual_summon_rate_purchased_upgrade(shop_item: ShopItem) -> void:
	Upgrades.ritual_summon_rate += .20
	shop_item.update_costs(shop_item.cost + Upgrades.ritual_summon_rate_cost_increase, Upgrades.ritual_summon_rate)


func _on_enemy_blood_dropped_purchased_upgrade(shop_item: ShopItem) -> void:
	Upgrades.enemy_blood_dropped += 1
	shop_item.update_costs(shop_item.cost + Upgrades.enemy_blood_dropped_cost_increase, Upgrades.enemy_blood_dropped)

