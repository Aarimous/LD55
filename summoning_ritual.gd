extends Node2D

@export var devil_pack : PackedScene

var summon_timout_count : float = 0
var summon_timout : float = 0
var duration

func _ready() -> void:
	duration = Upgrades.ritual_duration
	$Sprite2D.rotation_degrees = Game.rng.randi_range(0,360)
	set_summon_timout()

func _process(delta: float) -> void:
	
	
	
	summon_timout_count += delta
	$TextureProgressBar.value = summon_timout_count/summon_timout * 100
	
	if summon_timout_count >= summon_timout:
		var new_devil : Player  = devil_pack.instantiate()
		Game.main.player_units.add_child(new_devil)
		new_devil.global_position = global_position
		new_devil.init()
		
		set_summon_timout()
		
	duration -= delta
	if duration <= 0:
		queue_free()

func set_summon_timout():
	summon_timout_count = 0
	summon_timout = 1/Upgrades.ritual_summon_rate
	$TextureProgressBar.value = summon_timout_count/summon_timout * 100
