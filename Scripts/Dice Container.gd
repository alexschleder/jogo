extends HBoxContainer


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

enum dice_type {CHARACTER_DICE, OTHER}

export (PackedScene) var DiceButtonScene

func instantiate_dice(var diceAttribute : int, var diceSize : int) -> void:
	var instance = DiceButtonScene.instance()
	instance.type = dice_type.CHARACTER_DICE
	add_child(instance)
	var diceSprite : AnimatedSprite = instance.get_node("Dice")
	diceSprite.changeDiceSprite(diceAttribute)
	diceSprite.roll()
	instance.ChangeIcon()
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range (PlayerVariables.max_int_dice):
		instantiate_dice(GlobalEnums.Attributes.INT, i)
	for i in range (PlayerVariables.max_dex_dice):
		instantiate_dice(GlobalEnums.Attributes.DEX, i)
	for i in range (PlayerVariables.max_str_dice):
		instantiate_dice(GlobalEnums.Attributes.STR, i)
	
func reroll():
	for n in get_children():
		n.reroll()
	return
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
