extends CharacterBody2D

@onready var sprite : Sprite2D = get_node("Texture")
@export var move_speed: float = 32.0

func _physics_process(_delta: float) -> void:
	move()
	var _move := move_and_slide()
	sprite.animate(velocity)
	
func move() -> void:
	var direction: float = get_direction()
	velocity.x = direction * move_speed

func get_direction() -> float:
	return(
		Input.get_axis("ui_left","ui_right")
	)
