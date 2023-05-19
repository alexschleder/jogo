extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var ObjectInteractionContainer
# Called when the node enters the scene tree for the first time.
func _ready():
	ObjectInteractionContainer = get_parent()
	pass # Replace with function body.
	
func _button_pressed():
	print("Hello world!")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
