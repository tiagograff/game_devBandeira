extends Node2D

@onready var player: CharacterBody2D = get_node("MaskDude")
@onready var interface: CanvasLayer = get_node("Interface")

@export var scene_path: String 

func _ready() -> void:
	interface.update_health(player.max_health)
	trasition_sreen.connect(
		"start_level", Callable(self,"start_level")
	)
	
	if trasition_sreen.current_score != 0:
		player.total_score = trasition_sreen.current_score
		interface.update_score(trasition_sreen.current_score)
		
	if trasition_sreen.current_health != 0:
		interface.update_health(trasition_sreen.current_health)
		player.health = trasition_sreen.current_health
func start_level() -> void:
	pass
