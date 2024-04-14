extends HBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	%"Souls Amount".text = str(int(Game.souls))
	%"Souls Max".text = str(int(Game.max_souls))
