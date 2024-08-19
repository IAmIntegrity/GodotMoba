class_name Character

extends Node

#Character BASE values
@export var characterMovementSpeed: float:
	set(value):
		characterMovementSpeed = clamp(value, 0, 150)
@export var characterBasicAttackDamage: float:
	set(value):
		characterBasicAttackDamage = clamp(value, 0, 5000)
@export var characterBasicAttackSpeed: float:
	set(value):
		characterBasicAttackSpeed = clamp(value, 0.5, 2)
@export var characterHealth: float:
	set(value):
		characterHealth = clamp(value, 0, 10000)

func dealDamage(otherCharacter: Character): #to other
	print(otherCharacter.characterHealth)
	otherCharacter.characterHealth -= characterBasicAttackDamage
	print(otherCharacter.characterHealth)

func takeDamage(otherCharacter: Character): #from other
	print(characterHealth)
	characterHealth -= otherCharacter.characterBasicAttackDamage
	print(characterHealth)
