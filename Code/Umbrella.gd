extends RigidBody3D
class_name Umbrella

var timer: float = 0
var forcelocked:bool = false
var angle:float
var force: float
var initialtransform : Transform3D
var needsReset : bool = false

func _ready():
	get_parent().drag_stopped.connect(_on_gameplay_drag_stopped)
	initialtransform = global_transform

func _reset():
	needsReset = true
		
func _process(delta):
	timer += delta * 0.3
	if timer < 1 :
		var x = sin(timer * timer * 5 * PI)*0.002*timer
		var z = cos(timer * timer * 5 * PI)*0.002*timer
		var negtimer = max(0,0.5-timer)
		var y = cos(negtimer * negtimer * 40 * PI)*0.02*negtimer
		translate_object_local(Vector3(0,-1.123,0))
		rotate_object_local(Vector3(1,0,0),x)
		rotate_object_local(Vector3(0,0,1),z)
		translate_object_local(Vector3(0,1.123 + y,0))
		sleeping = timer < 0.8

func _integrate_forces(state):
	if timer > 1 :
		if(!forcelocked):
			forcelocked = true
			angle = randf()* 2 * PI
			force = randf() * 35
		state.apply_central_force(Vector3(sin(angle)* force,0,cos(angle)* force))

func _physics_process(_delta):
	if needsReset:
		needsReset = false
		self.angular_velocity = Vector3.ZERO
		self.linear_velocity = Vector3.ZERO
		self.global_transform = initialtransform
		self.angle = 0
		self.force = 0
		self.timer = 0
		self.forcelocked = false


func _on_gameplay_drag_stopped(dragged:Node3D):
	if(dragged == self):
		timer = 0
		angular_velocity = Vector3.ZERO
		linear_velocity = Vector3.ZERO
		angle = 0
		force = 0
		forcelocked = false

