extends AnimatedSprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func on_toggle_object(object):
	print("test")
	if get_frame() == 0:
		set_frame(1) 
	else:
		set_frame(0) 

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
