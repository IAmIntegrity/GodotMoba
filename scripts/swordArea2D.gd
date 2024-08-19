extends Area2D

@onready var knightCharacterBuild = $"../../CharacterBuild"

func _on_body_entered(body): #characters
	if body.has_method("getCharacterBuild"):
		body.getCharacterBuild().takeDamage(knightCharacterBuild)

func _on_area_entered(area): #minions
	if area.get_node("../CharacterBuild") != null:
		area.get_node("../CharacterBuild").takeDamage(knightCharacterBuild)
