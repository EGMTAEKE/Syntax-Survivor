extends CanvasLayer

@onready var player = null

var abilities = [
	preload("res://scenes/abilities/speedBonus.tres"),
	preload("res://scenes/abilities/healthBonus.tres"),
	preload("res://scenes/abilities/damageBonus.tres")
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("players")
	get_tree().paused = true
	abilities.shuffle()
	 
	for i in range(3):
		var card  = $Panel/HBoxContainer.get_child(i)
		var ability = abilities[i]
		
		card.get_node("NameLabel").text = ability.name
		card.get_node("DescLabel").text = ability.description
		
		var button = card.get_node("SelectButton") 
		button.pressed.connect(func():chooseAbility(ability))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func chooseAbility(ability):
	if player == null:
		player = get_tree().get_first_node_in_group("players")
	player.apllyAbility(ability)
	get_tree().paused = false
	queue_free()
