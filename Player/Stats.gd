extends Node
class_name Stats

signal smieci_changed

var smieci:int:
	set(value):
		smieci = clamp(value,0, 100)
		emit_signal('smieci_changed', smieci)
