extends AnimatedSprite

enum DiceType{
	D4 = 4,
	D6 = 6,
	D8 = 8,
}

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

var rng : RandomNumberGenerator = RandomNumberGenerator.new();
export (int) var diceSize = 6;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body. 
	
func roll() -> int:
	rng.randomize();
	var number : int = rng.randi_range(0, diceSize);
	print(number)
	frame = number;
	return number;
	
func changeDiceSprite(var diceAttribute : int) -> void:
	var animatedSpriteName : String
	match diceAttribute:
		GlobalEnums.Attributes.DEX:
			animatedSpriteName = "green"
		GlobalEnums.Attributes.INT:
			animatedSpriteName = "blue"
		GlobalEnums.Attributes.STR:
			animatedSpriteName = "red"
			
	animatedSpriteName += "_" + str(diceSize)
	print(animatedSpriteName)
	animation = animatedSpriteName	

func GetCurrentFrame() -> Texture:
	return frames.get_frame(animation, frame)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
