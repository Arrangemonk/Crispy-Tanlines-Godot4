extends Button

func _on_pressed():
	var squeeze = get_parent().get_node("Squeeze") as AudioStreamPlayer3D
	var armour = get_parent().get_node("Armour") as Armour
	squeeze.play()
	armour.lotion = min(1,armour.lotion + 1)
	
