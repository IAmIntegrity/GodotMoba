extends CharacterBody2D

@onready var knightAnimatedSprite = $KnightAnimatedSprite2D
@onready var knightSword = $knightSword
@onready var swordAreaAnimation = $knightSword/SwordAnimationPlayer
@onready var swordArea2D = $knightSword/SwordArea2D
@onready var basicAttackTimer = $knightSword/SwordArea2D/SwordBasicAttackTimer
@onready var knightCharacterBuild = $CharacterBuild

func setSwordAnimationValues(value: bool): #based on knight flip h, sets values for sword animations
	if value == false:
		knightSword.flip_h = false #for mirror sword sprite on vertical axis
		knightSword.position.x = 7 #moves sword where needed
		swordArea2D.rotation_degrees = 45 #normal sword area rotation
		swordArea2D.position.x = 1 #normal sword area x pos
	else:
		knightSword.flip_h = true
		knightSword.position.x = -7 
		swordArea2D.rotation_degrees = -45
		swordArea2D.position.x = -1

func _physics_process(_delta):
	#Getting Movement
	var directionX = Input.get_axis("moveLeft", "moveRight")
	var directionY = Input.get_axis("moveUp", "moveDown")
	if directionX:
		velocity.x = directionX * knightCharacterBuild.characterMovementSpeed
	else:
		velocity.x = move_toward(velocity.x, 0, knightCharacterBuild.characterMovementSpeed)
	if directionY:
		velocity.y = directionY * knightCharacterBuild.characterMovementSpeed
	else:
		velocity.y = move_toward(velocity.y, 0, knightCharacterBuild.characterMovementSpeed)
		
	#Flipping Knight
	if directionX > 0:
		knightAnimatedSprite.flip_h = false #default knight sprite faces right
		if basicAttackTimer.time_left == 0:
			setSwordAnimationValues(false)
	elif directionX < 0:
		knightAnimatedSprite.flip_h = true
		if basicAttackTimer.time_left == 0:
			setSwordAnimationValues(true)
	
	#Setting Animations
	if directionX == 0 and directionY == 0:
		knightAnimatedSprite.play("knightIdle")
		knightSword.play("swordIdle")
	else:
		knightAnimatedSprite.play("knightRun")
		knightSword.play("swordRun")

	#Turning Area on and off for sword
	if Input.is_action_pressed("basicAttack") and basicAttackTimer.time_left == 0:
		if knightAnimatedSprite.flip_h == false:
			swordAreaAnimation.play("swordAreaRightAttack")
		else:
			setSwordAnimationValues(false) #needed because animations are based on assuming normal idle values
			swordAreaAnimation.play("swordAreaLeftAttack")
		print("attacking")
		basicAttackTimer.start()
	
	move_and_slide()

func _on_timer_timeout():
	swordAreaAnimation.play("swordAreaOff")
	
	#The following code runs after animation is done
	knightSword.rotation_degrees = 0 #resets sword rotation
	knightSword.position.y = -7 #resets sword y pos
	
	if knightAnimatedSprite.flip_h == false: #sets sword stuff so doesnt look funny finishing attack animation
		setSwordAnimationValues(false)
	elif knightAnimatedSprite.flip_h == true:
		setSwordAnimationValues(true)
	
	print("area off")
