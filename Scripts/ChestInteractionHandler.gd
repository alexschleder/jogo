extends GridContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

enum dice_type {CHARACTER_DICE, OTHER}
var root_node

signal on_open_chest
signal open_door       
signal fountain_use
signal reroll_potion_use
signal defeat_enemy
signal ladder_use
export (String) var signal_name #on_open_chest

# Called when the node enters the scene tree for the first time.
func _ready():
	$DiceButton.type = dice_type.OTHER
	root_node = get_node("/root/Game")
	root_node.connect("before_object_resolve", $DiceButton, "on_before_object_resolve")
	pass # Replace with function body.

func _on_ObjectResolveButton_pressed():
	if ($DiceButton.from_dice == null):
		print ("no dice to resolve")
		return
	print("Object Resolve button pressed")
	emit_signal(signal_name, $RuleLabel.validate_resolve())
	pass # Replace with function body.
	
