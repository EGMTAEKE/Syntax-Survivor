extends CanvasLayer

@onready var player = null

var abilities = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("players")
	get_tree().paused = true
	abilities = global.ability.duplicate()
	abilities.shuffle()
	var count = min(3,abilities.size())
	if count == 0:
		get_tree().paused = false
		queue_free()
	for i in range(count):
		var card  = $Panel/HBoxContainer.get_child(i)
		var ability = abilities[i]
		
		card.get_node("NameLabel").text = ability.name
		card.get_node("DescLabel").text = ability.description
		
		var button = card.get_node("SelectButton") 
		button.pressed.connect(func():chooseAbility(ability))
	
	for i in range(count,3):
		$Panel/HBoxContainer.get_child(i).visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func chooseAbility(ability):
	if player == null:
		player = get_tree().get_first_node_in_group("players")
	player.apllyAbility(ability)
	ability.Level += 1
	if ability.lastLevel == ability.Level:
		global.ability.erase(ability)
	get_tree().paused = false
	queue_free()
