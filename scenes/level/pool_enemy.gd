extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func  getEnemy():
	for enemy in get_children():
		if enemy.visible == false and enemy.flagDead == false:
			return enemy
	return null	
	
func returnEnemy(enemy):
	enemy.visible = false
	enemy.process_mode = Node.PROCESS_MODE_DISABLED
	enemy.position = Vector2(-500,-500)
	enemy.maxHealth = 100

func checkPoolAlive():
	var allDead = true
	
	for enemy in get_children():
		if not "flagDead" in enemy:
			continue
		if enemy.visible == true and not enemy.flagDead:
			allDead = false
			break
	return allDead

func reset():
	for enemy in get_children():
		if "flagDead" in enemy:
			enemy.flagDead = false
