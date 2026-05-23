extends CharacterBody2D

var speed = 150
var direction = Vector2.ZERO
var anim
var targets = []
var health = 100
var maxHealth = 100
var experience = 0
var maxExp = 100
var damageMultiplier = 1
var expMult = 1
var saveDamage = 1
var activeAbility = []

@onready var shootTimer = $ShootTimer
@onready var spawn = $Spawn
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	z_index = 1
	cheak()
	$ProgressBar.value = 100
	%experienceBar.value = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	Movement()
	direction = direction.normalized()
	velocity = speed * direction
	#$ProgressBar.value = $ProgressBar.value
	
	move_and_slide()

func Movement():
	direction.x = Input.get_action_strength("RightMove")- Input.get_action_strength("LeftMove")
	direction.y = Input.get_action_strength("DownMove")- Input.get_action_strength("UpMove")
	updateAnim()

func updateAnim():
	anim = $AnimatedSprite2D
	if direction.x == 0:
		anim.stop()
	elif direction.x > 0:
		anim.flip_h = false
		anim.play("catRun")
	elif  direction.x < 0:
		anim.flip_h = true
		anim.play("catRun")
	


func _on_detection_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		targets.append(body)
		if shootTimer.is_stopped():
			shootTimer.start()
		print("враг в зоне")

func cursorshoot():
	if targets.is_empty():
		return
	var cursor_scene = preload("res://scenes/cursor/cursor.tscn")
	var cursor = cursor_scene.instantiate()
	cursor.global_position = spawn.global_position
	cursor.direction = (targets[0].global_position - global_position).normalized()
	
	get_parent().add_child(cursor)
	


func _on_shoot_timer_timeout() -> void:
	if targets.is_empty():
		return
	apllyActiveAbility(activeAbility)
	
	cursorshoot() # Replace with function body.


func _on_detection_body_exited(body: Node2D) -> void:
	if body in targets:
		targets.erase(body)
		if targets.is_empty():
			shootTimer.stop()
			print("враг не в зоне")
		cheak()

func cheak():
	for body in $detection.get_overlapping_bodies():
		if body.is_in_group("enemies") and body not in targets:
			targets.append(body)
			shootTimer.start()
		

func takeDamage(damageValue):
	health -= damageValue
	$ProgressBar.value = health
	print("урон получен")
	if health <= 0:
		print("Смерть")
		die()

func takeExp(expValue):
	experience += expValue * expMult
	if experience >= maxExp:
		print("Уровень повышен")
		experience = 0
		maxExp = maxExp + 200
		%experienceBar.max_value = maxExp 
		maxHealth = maxHealth + 20
		$ProgressBar.max_value = maxHealth
		health = maxHealth
		levelUpMenuOpen()
		
	%experienceBar.value = experience
	$ProgressBar.value = health
	
	

func levelUpMenuOpen():
	var menu = preload("res://scenes/menu/level_up_menu.tscn").instantiate()
	get_tree().root.add_child(menu)
	

func die():
	call_deferred("backToMenu")
	
func backToMenu():
	get_tree().change_scene_to_file("res://scenes/menu/menu.tscn")

func apllyActiveAbility(activeAbilityArray):
	if targets.is_empty():
		return
		
	for ability in activeAbilityArray:
		if ability.preloadAbility == null:
			continue
		var Scene = ability.preloadAbility
		var Spell = Scene.instantiate()
		Spell.global_position = spawn.global_position
		Spell.direction = (targets.pick_random().global_position - global_position).normalized()
		get_parent().add_child(Spell)
		
	
func apllyAbility(ability):
	if ability.preloadAbility != null:
		activeAbility.append(ability)
	if ability.speedBonus != 0:
		$ShootTimer.wait_time = $ShootTimer.wait_time * (1 - ability.speedBonus)
	if ability.healthBonus != 0:
		maxHealth += ability.healthBonus 
		health = maxHealth
		$ProgressBar.max_value = maxHealth
		$ProgressBar.value = health
	if ability.damageBonus != 0:
		damageMultiplier += ability.damageBonus
		saveDamage = damageMultiplier
		
func  apllyItem(item):
	speed += item.itemSpeed
	damageMultiplier += item.itemDamage
	saveDamage = damageMultiplier
	expMult += item.itemExp

func takeRune(color):
	$RunesTimer.start()
	if color == Color.CRIMSON:
		damageMultiplier = 1000
	elif color == Color.AQUA:
		health = maxHealth
	elif color == Color.GREEN_YELLOW:
		speed += 100


func _on_runes_timer_timeout() -> void:
	$RunesTimer.stop()
	damageMultiplier = saveDamage
	speed = 150
