extends Sprite2D

@export var animation: AnimationPlayer = null

func animate(velocity: Vector2) -> void:
	change_orientation_based_on_direction(velocity.x)
	horizontal_move_behavior(velocity.x)

func change_orientation_based_on_direction(direction: float) ->void:
	if direction > 0:
		flip_h = false
	if direction < 0:
		flip_h = true

func horizontal_move_behavior(direction: float) -> void:
	if direction != 0:
		animation.play("run")
		return
	animation.play("idle")
