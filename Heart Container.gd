extends HBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export (int) var maxHeart = 3
export (PackedScene) var HeartSpriteScene

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(maxHeart):
		instantiate_heart()
	pass # Replace with function body.
	
func instantiate_heart():
	var instance = HeartSpriteScene.instance()
	add_child(instance)
	pass
		


