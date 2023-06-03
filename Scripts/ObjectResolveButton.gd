extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal on_open_chest
var rule_label

# Called when the node enters the scene tree for the first time.
func _ready():
	rule_label = get_parent().get_node("RuleLabel")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
