extends Button

func _on_pressed():
	var treeroot = get_tree().root.get_node("Crispy")
	var menu = treeroot.get_node("Menu") as Control
	var credits = treeroot.get_node("Credits") as Control
	credits.visible = true;
	menu.visible = false;