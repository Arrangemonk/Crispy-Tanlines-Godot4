extends ProgressBar

class_name Armour

@export var shadow:float = 1
@export var lotion:float = 1
var timer = 0;
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func getShadow() -> float:
	var all:float = 0;
	var hit:float = 0;
	var parent = get_parent() as Node3D
	var exclude = [self,parent.get_node("Environment")]
	var light = parent.get_node("Sunlight2") as DirectionalLight3D
	var girl = parent.get_node("Girl") as MeshInstance3D
	var mdt = MeshDataTool.new() 
	var mesh = girl.get_mesh()
	var worldspace = parent.get_world_3d().direct_space_state
	mdt.create_from_surface(mesh, 0)
	var direction = light.global_transform * Vector3(0,0,-1)
	var params = PhysicsRayQueryParameters3D.new()
	params.exclude = exclude
	params.hit_from_inside = true
	for vtx : int in range(mdt.get_vertex_count()):
		all = all + 1
		var vert: Vector3 = girl.global_transform * mdt.get_vertex(vtx)
		params.from = vert
		params.to = vert + direction * 1000
		var result : Dictionary = worldspace.intersect_ray(params)
		if(result):
			hit = hit + 1
			#print(result.collider)
	print("hit ",hit," all ",all)
	return min(1,hit / all * 1.3)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer = timer + delta
	if timer < 0.3 :
		return
	timer = 0
	lotion = max(0,lotion - delta)
	shadow = getShadow()
	value = (lotion + shadow) * 50
