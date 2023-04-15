extends CanvasLayer

signal start_level

@onready var animation: AnimationPlayer = get_node("Animation")

var target_path: String

func fade_in() -> void:
	animation.play("fade_in")


func on_animation_finished(anim_name: String) -> void:
	if anim_name == "fade_in":
		var _change_scene: bool = get_tree().change_scene_to_file(target_path)
		animation.play("fade_out")
	if anim_name == "fade_out":
		var _start: bool = emit_signal("start_level") 
