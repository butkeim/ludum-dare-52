extends Area2D


var cutable := true
var grabable := false
var apply_gravity := false

export(int, "PigeonHead", "PigeonFoot", "PigeonWing", "PigeonTail", "FlowerHead", "FlowerRoot", "Fire") var character_class

func _input_event(viewport, event, shape_idx):

	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		var cut = get_tree().root.find_node("Cut", true, false)
		if cutable and abs($CutShape2D.transform.y.dot(cut.transform.x)) < 0.5:
			cut.get_node("AudioStreamPlayer").play()
			$CutShape2D.disabled = true
			$GrabShape2D.disabled = false
			move_out()
			grabable = true
			cutable = false
		elif grabable:
			move_in_chaudron()

func _process(delta):
	if apply_gravity:
		position.y += delta * 1000.0

func move_in_chaudron():
		var root = get_node("/root/Main")
		var fire = root.get_node("Chaudron/ColorRect")

		if root.add_ingredient(character_class):
			fire.material.set_shader_param("brighter_color", Color.green)
		else:
			fire.material.set_shader_param("brighter_color", Color.red)

		var tween = create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

		tween.tween_property(self, "global_position", Vector2(1720, 40) - $GrabShape2D.position, 0.5)
		tween.tween_property(self, "global_position", Vector2(1720, 400) - $GrabShape2D.position, 0.5).set_ease(Tween.EASE_IN_OUT)
		tween.tween_callback(self, "add_element_to_receipe")
		tween.tween_property(fire.material, "shader_param/brighter_color", Color.white, 0.5)
		tween.tween_callback(self, "queue_free")

func add_element_to_receipe():
	return

func move_out():
	
	var tween = create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

	tween.tween_property(self, "global_position", global_position - $CutShape2D.global_transform.y * 50.0, 0.5)
