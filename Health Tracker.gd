extends HBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.based_health_changed.connect(_on_based_health_changed)

func _on_based_health_changed(new_value, max_value):
	%"Health Amount".text = str(int(new_value))
	%"Health Max".text = str(int(max_value))
