extends Node2D

@export var scene_path: String 

func _ready() -> void:
	trasition_sreen.target_path = scene_path
	trasition_sreen.connect(
		"start_level", Callable(self,"start_level")
	)
func start_level() -> void:
	pass
