extends CharacterBody2D

@onready var sprite: Sprite2D = get_node("Texture")
@onready var stomp_area_collision: CollisionShape2D = get_node("StompArea/Collision")

var is_dead: bool = false
var jump_count: int = 0
var is_on_double_jump : bool = false
var on_knockback: bool = false
var knockback_direction: Vector2
var health: float = 25.0
var max_health: float = 0.0

@export var move_speed: float = 96.0
@export var jump_speed: float = -192.0
@export var gravity_speed: float = 512.0
@export var damage: int = 5

func _ready() -> void:
	max_health = health

func _physics_process(delta: float) -> void:
	if is_dead == true:
		return
	if on_knockback == true:
		knockback_move()
		return
	move()
	velocity.y += delta * gravity_speed
	var _move := move_and_slide()
	jump()
	sprite.animate(velocity)

func knockback_move() -> void:
	velocity = knockback_direction * move_speed * 2
	var _move := move_and_slide()
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
		stomp_area_collision.set_deferred("disabled", true)
		
	if Input.is_action_just_pressed("jump") and jump_count < 2:
		stomp_area_collision.set_deferred("disabled", false)
		velocity.y = jump_speed
		jump_count += 1
		
	if jump_count == 2 and not is_on_double_jump:
		sprite.action_behavior("double_jump")
		is_on_double_jump = true
		
func update_health(target_position: Vector2, value: int, type: String) -> void:
	if is_dead == true:
		return
	if type == "decrease":
		knockback_direction = (global_position - target_position).normalized()
		sprite.action_behavior("hit")
		on_knockback = true
		health = clamp(health - value,0,max_health)
	if type == "increase":
		health = clamp(health + value, 0, max_health)
	if health == 0:
		is_dead = true
		sprite.action_behavior("dead")
	return

func on_stomp_area_entered(_area):
	pass
	
func on_stomp_body_entered(body):
	if body.is_in_group("hazard") and body.is_invinceble == false:
		body.update_health(damage)
		
		knockback_direction = (global_position - body.global_position).normalized()
		sprite.action_behavior("hit")
		on_knockback = true
