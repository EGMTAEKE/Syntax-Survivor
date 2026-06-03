extends Control

@onready var lineEdit = $CanvasLayer/LineEdit
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_touch_screen_button_pressed() -> void:
	if lineEdit.text.length()<=16:
		global.mouseLabel = lineEdit.text
		get_tree().change_scene_to_file("res://scenes/menu/menu.tscn")
	


func _on_save_button_released() -> void:
	if lineEdit.text.length()<=16:
		global.mouseLabel = lineEdit.text
		await get_tree().create_timer(0.2).timeout
		get_tree().change_scene_to_file("res://scenes/menu/menu.tscn")
