extends Node2D

var timeStart = 0
func _ready() -> void:
	timeStart = Time.get_ticks_msec()

func elapsedTime():
	var time = Time.get_ticks_msec() - timeStart
	return time / 1000

func _process(_delta: float) -> void:
	$CanvasLayer/TimeLive.text = str(elapsedTime())
