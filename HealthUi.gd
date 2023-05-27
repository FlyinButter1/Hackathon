extends Control


var maxHearts:
	set(value):
		maxHearts = value
		$maxHearts.size.x = value * 16
			

var Hearts:
	set(value):
		Hearts = value
		if value != 0:
			$Hearts.size.x = value * 16
		else:
			$Hearts.scale.x = 0
			

func _on_hurtbox_health_changed(health):
	self.Hearts = health


func _on_hurtbox_max_health_changed(max_health):
	self.maxHearts = max_health
