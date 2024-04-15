extends Unit
class_name Based


func _ready() -> void:
	health_comp = $HealthComp
	Game.based = self
	
	health_comp.health_changed.connect(_on_health_changed)
	health_comp.death_event.connect(_on_death_event)
	health_comp.init(max_health)

	_on_health_changed(health_comp.current_health, health_comp.max_health)
	
func heal_based(amount):
	health_comp.change_health(amount)

func calc_velocity():
	pass

func _process(delta: float) -> void:
	%"Souls Bar".value = (Game.souls/Game.max_souls) * 100
	
func _physics_process(delta: float):
	pass

func _on_health_changed(new_value, max_value):
	print("_on_health_changed ", new_value, " ", max_value)
	%HealthBar.value = (float(new_value) / float(max_value)) * 100
	
	SignalBus.based_health_changed.emit(new_value, max_value)
	
	
func _on_death_event():
	Game.main.game_over(false)
	

