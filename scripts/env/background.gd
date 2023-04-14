extends ParallaxBackground

@onready var background_layer: TextureRect = get_node("ParallaxLayer/BackgroundLayer")

var background_images_list: Array = [
	"res://assets/Background/Blue.png",
	"res://assets/Background/Brown.png",
	"res://assets/Background/Gray.png",
	"res://assets/Background/Green.png",
	"res://assets/Background/Pink.png",
	"res://assets/Background/Purple.png",
	"res://assets/Background/Yellow.png"
]
func _ready() -> void:
	background_layer.texture = load (
		background_images_list[
			randi() % background_images_list.size()
		]
	)
