extends Label

@export var characterBuild: Character
@export var character: Node
@onready var health_label = $"."

var yDifference: float
var xDifference: float

func _ready():
	yDifference = health_label.position.y - character.position.y
	xDifference = health_label.position.x - character.position.x

func _process(delta):
	health_label.position.y = character.position.y + yDifference
	health_label.position.x = character.position.x + xDifference
	health_label.text = str(characterBuild.characterHealth)
