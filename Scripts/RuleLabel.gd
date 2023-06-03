extends Label

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(GlobalEnums.ResolveType) var type
var diceButton

# Called when the node enters the scene tree for the first time.
func _ready():
	diceButton = get_parent().get_node("DiceButton")
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
