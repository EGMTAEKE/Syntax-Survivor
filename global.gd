extends Node

var items = [
	preload("res://scenes/items/chestItems/expItem.tres"),
	preload("res://scenes/items/chestItems/damageItem.tres"),
	preload("res://scenes/items/chestItems/speedItem.tres")
]

var ability = [
	preload("res://scenes/abilities/passives/speedBonus.tres"),
	preload("res://scenes/abilities/passives/healthBonus.tres"),
	preload("res://scenes/abilities/passives/damageBonus.tres"),
	preload("res://scenes/abilities/fireBall.tres")
]
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
