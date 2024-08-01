extends Button

func _on_pressed():
	var treeroot = get_tree().root.get_node("Crispy")
	var menu = treeroot.get_node("Menu") as Control
	var gameplay = treeroot.get_node("Gameplay") as Node3D
	gameplay.visible = true;
	gameplay.set_physics_process(true);
	menu.visible = false;
