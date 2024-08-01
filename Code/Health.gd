extends ProgressBar

var gameover : Control
var youlose : Control
var parent : Node3D
var armour : Armour
var treeroot : Node3D
var timer : float
# Called when the node enters the scene tree for the first time.
func _ready():
	treeroot = get_tree().root.get_node("Crispy")
	parent = get_parent()
	armour = parent.get_node("Armour")
	youlose = treeroot.get_node("YouLose")
	gameover = treeroot.get_node("GameOver")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !parent.visible:
		return
	timer = timer + delta
	value = value - delta * ((100 -armour.value)/50)
	if value == 0:
		value = 100;
		armour.lotion = 1
		timer = 0
		youlose.visible = true
		parent.visible = false
	elif timer > 360:
		value = 100;
		armour.lotion = 1
		timer = 0
		gameover.visible = true
		parent.visible = false
