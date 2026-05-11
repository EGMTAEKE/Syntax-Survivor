extends Node2D

var target = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	z_index = -1

func targetChest(targetChest):
	target = targetChest
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if target == null:
		queue_free()
	if target != null:
		var diraction = target.global_position - get_parent().global_position
		rotation = diraction.angle()
