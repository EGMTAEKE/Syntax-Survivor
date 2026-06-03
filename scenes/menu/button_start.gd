extends TouchScreenButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


#func _on_pressed() -> void:
	#print("Кнопка нажата")
	#get_tree().change_scene_to_file("res://scenes/level/level.tscn")


func _on_released() -> void:
	print("Кнопка нажата")
	await get_tree().create_timer(0.2).timeout
	get_tree().change_scene_to_file("res://scenes/level/level.tscn")
