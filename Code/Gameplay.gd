extends Node3D

class_name Gameplay

signal drag_stopped(dragged)

var draggingCollider : Node3D
var mousePosition : Vector3
var doDrag : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	Engine.max_fps = 60
	set_physics_process(false)

func _input(event):
	var treeroot = get_tree().root.get_node("Crispy")
	var menu = treeroot.get_node("Menu") as Control
	if event is InputEventKey:
		if event.keycode == KEY_ESCAPE:
			menu.visible = true;
			self.visible = false;
	else:
		var intersect : Dictionary = get_mouse_intersect(event.position)

		if event is InputEventMouse:
			if intersect: mousePosition = intersect.position

		if event is InputEventMouseButton:
			var leftButtonPressed = event.button_index == MOUSE_BUTTON_LEFT && event.is_pressed()
			var leftButtonReleased = event.button_index == MOUSE_BUTTON_LEFT && event.is_released()

			if leftButtonReleased:
				doDrag = !doDrag
				drag_and_drop(intersect)
			elif leftButtonPressed:
				doDrag = true
				drag_and_drop(intersect)

func drag_and_drop(intersect : Dictionary):
	if !draggingCollider && doDrag:
		if intersect.collider.name != 'Environment':
			draggingCollider = intersect.collider
			var pickup = get_node("Pickup") as AudioStreamPlayer3D
			pickup.position = intersect.position
			pickup.play()
		#draggingCollider.set_collision_layer(false)
	elif draggingCollider:
		var drop = get_node("Drop") as AudioStreamPlayer3D
		drop.position = intersect.position
		drop.play()
		drag_stopped.emit(draggingCollider)
		#draggingCollider.set_collision_layer(true)		
		draggingCollider = null

func _process(_delta: float):
	if draggingCollider:
		draggingCollider.global_position = Vector3(mousePosition.x,1.0,mousePosition.z)
		draggingCollider.global_rotation = Vector3.ZERO


func get_mouse_intersect(ep : Vector2) -> Dictionary:
	var currentCamera = get_viewport().get_camera_3d();
	var params = PhysicsRayQueryParameters3D.new()
	params.from = currentCamera.project_ray_origin(ep)
	params.to = currentCamera.project_position(ep,1000)

	var worldspace = get_world_3d().direct_space_state
	var result = worldspace.intersect_ray(params)

	return result
