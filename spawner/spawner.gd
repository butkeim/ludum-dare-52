extends Area2D

export(PackedScene) var object_to_spawn

var v = 0.0
var s = 50.0
var wiggle := false

func _ready():
	pass


func _input_event(viewport, event, shape_idx):

	if event is InputEventMouseButton  and event.pressed and event.button_index == BUTTON_LEFT:
		input_pickable = false
		clear_table()
		spawn_ingredient()


func clear_table():
	var root = get_node("/root/Main")

	var tween = create_tween().set_trans(Tween.TRANS_BACK)

	if root.current_ingredient != null:
		
		tween.tween_property(root.current_ingredient, "global_position", Vector2(1100, 610), 1.0)
		tween.tween_callback(root.current_ingredient, "queue_free")

	root.current_ingredient = object_to_spawn.instance()
	root.add_child(root.current_ingredient)

	tween.tween_property(root.current_ingredient, "global_position", Vector2(1100, -16), 0.5)

	tween.tween_property(self, "input_pickable", true, 0.0)

	return
	
func spawn_ingredient():

	return

func _process(delta):

	if wiggle:
		v += delta * s
	else:
		v -= delta * s

	v = clamp(v, 0.0, 10.0)

	$Sprite.position.x = sin(OS.get_ticks_msec() * 0.001 * PI * 2.0) * v


func _on_Spawner_mouse_entered():
	wiggle = true
	pass # Replace with function body.


func _on_Spawner_mouse_exited():
	wiggle = false
	pass # Replace with function body.
