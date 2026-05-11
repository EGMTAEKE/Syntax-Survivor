extends CanvasLayer

var questions = [
	preload("res://scenes/question/question_1.tres"),
	preload("res://scenes/question/question_2.tres"),
	preload("res://scenes/question/question_3.tres"),
	preload("res://scenes/question/question_4.tres"),
	preload("res://scenes/question/question_5.tres"),
	preload("res://scenes/question/que_6.tres"),
	preload("res://scenes/question/que_7.tres"),
	preload("res://scenes/question/que_8.tres"),
	preload("res://scenes/question/que_9.tres"),
	preload("res://scenes/question/que_10.tres")
]
var runeColor = null
var player = null
var quest = null
var rune = null
func _ready() -> void:
	
	runeColor = get_tree().get_first_node_in_group("runes")
	
	player = get_tree().get_first_node_in_group("players")
	get_tree().paused = true
	questions.shuffle()
	quest = questions[0]
	$Panel/Text.text = quest.name
	$Panel/Description.text = quest.description
	$Panel/HBoxContainer/optionOne/Label.text = quest.optionOne
	$Panel/HBoxContainer/optionTwo/Label.text = quest.optionTwo
	$Panel/HBoxContainer/optionThree/Label.text = quest.optionThree


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_option_one_pressed() -> void:
	if quest.countOptionTrue == "One":
		print("верный ответ")
		player.takeRune(rune.get_node("Polygon2D").color)
		if rune:
			rune.queue_free()
	else:
		print("не верный ответ")
		if rune:
			rune.queue_free()
	get_tree().paused = false
	queue_free()


func _on_option_two_pressed() -> void:
	if quest.countOptionTrue == "Two":
		print("верный ответ")
		player.takeRune(rune.get_node("Polygon2D").color)
		if rune:
			rune.queue_free()
	else:
		print("не верный ответ")
		if rune:
			rune.queue_free()
	get_tree().paused = false
	queue_free()


func _on_option_three_pressed() -> void:
	if quest.countOptionTrue == "Three":
		print("верный ответ")
		player.takeRune(rune.get_node("Polygon2D").color)
		if rune:
			rune.queue_free()
	else:
		print("не верный ответ")
		if rune:
			rune.queue_free()
	get_tree().paused = false
	queue_free()

func setRune(runeNode):
	rune = runeNode
