extends AnimatedSprite2D

func _ready() -> void:
	pass

func on_animation_finished():
	queue_free()
