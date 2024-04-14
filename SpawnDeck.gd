extends Resource
class_name SpawnDeck

@export var deck : Array[SpawnCard]


var difficulty_matrix = {
	Game.ENTITY_TYPES.SMALL_HUMAN : 5
	
}
	
	
func generate_random_card() -> SpawnCard:
	var new_card = SpawnCard.new()

	new_card.cost = 10 * Game.difficutly_number
	
	var spawn_types_array : Array[Game.ENTITY_TYPES] = [Game.ENTITY_TYPES.SMALL_HUMAN]
	new_card.spawn_types = spawn_types_array
	var spawn_amounts_array : Array[int] = [round(Game.difficutly_number)]
	new_card.spawn_amounts = spawn_amounts_array
	return new_card
	

