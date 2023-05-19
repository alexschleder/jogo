extends HBoxContainer


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

export (PackedScene) var DiceButtonScene
var lastAvailableSpot : int = 0
export (int) var diceMargin : int = 0

func instantiate_dice(var diceAttribute : int, var diceSize : int) -> void:
	var instance = DiceButtonScene.instance()
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
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
