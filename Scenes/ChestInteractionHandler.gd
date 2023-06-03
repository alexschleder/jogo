extends GridContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal on_open_chest

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ObjectResolveButton_pressed():
	print("test")
	emit_signal("on_open_chest", $RuleLabel.validate_resolve())
	pass # Replace with function body.
