extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var root_node
var object_interaction_scene

# Called when the node enters the scene tree for the first time.
func _ready():
	root_node = get_node("/root/Game")
	pass # Replace with function body.

func instantiate_object_interaction_scene(var packed_scene):
	var instance = packed_scene.instance()
	instance.rect_scale = Vector2(0.25, 0.25)
	$CenterContainer.add_child(instance)
	$ObjectInteractionBackground.visible = true
	instance.connect("on_open_chest", root_node,"on_open_chest")
	print(instance.is_connected("on_open_chest", root_node,"on_open_chest"))
	object_interaction_scene = instance
	pass
	
func close_object_intaraction_scene():
	object_interaction_scene.queue_free()
	$ObjectInteractionBackground.visible = false
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Button_pressed():
	close_object_intaraction_scene()
	pass # Replace with function body.
