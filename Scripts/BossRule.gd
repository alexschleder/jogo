extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var dice_button

# Called when the node enters the scene tree for the first time.
func _ready():
	dice_button = get_parent().get_node("DiceButton")
	pass # Replace with function body.
	
func validate_resolve() -> int:
	var dice_value = dice_button.GetDiceValue()
	print ("VALOR:", dice_value)
	if (dice_value >= 6):
		return 0
	else:
		return -4

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
