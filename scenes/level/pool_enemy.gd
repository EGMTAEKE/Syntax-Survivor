extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func  getEnemy():
	for enemy in get_children():
		if enemy.visible == false:
			return enemy
	return null	
	
func returnEnemy(enemy):
	enemy.visible = false
	enemy.process_mode = Node.PROCESS_MODE_DISABLED
	enemy.position = Vector2(-500,-500)
	
		
