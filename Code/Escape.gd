extends Control

func _input (event):
	var treeroot = get_tree().root.get_node("Crispy")
	var menu = treeroot.get_node("Menu") as Control
	if event is InputEventKey:
		if event.keycode == KEY_ESCAPE:
			menu.visible = true;
			self.visible = false;

