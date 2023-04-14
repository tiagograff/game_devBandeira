extends CharacterBody2D

var jump_count: int = 0
var is_on_double_jump : bool = false

@onready var sprite: Sprite2D = get_node("Texture")
@export var move_speed: float = 96.0
@export var jump_speed: float = -192.0
@export var gravity_speed: float = 512.0

func _physics_process(delta: float) -> void:
	move()
	velocity.y += delta * gravity_speed
	var _move := move_and_slide()
	jump()
	sprite.animate(velocity)
	
func move() -> void:
	var direction: float = get_direction()
	velocity.x = direction * move_speed
	
func get_direction() -> float:
	return(
		Input.get_axis("walk_left","walk_right")
	)
func jump() -> void:
	if is_on_floor():
		jump_count = 0
		is_on_double_jump = false
		
	if Input.is_action_just_pressed("jump") and jump_count < 2:
		velocity.y = jump_speed
		jump_count += 1
		
	if jump_count == 2 and not is_on_double_jump:
		sprite.action_behavior("double_jump")
		is_on_double_jump = true
