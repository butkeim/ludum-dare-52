extends Area2D


var v = 0.0
var s = 50.0
var wiggle := false

func _ready():
	pass

func _input_event(viewport, event, shape_idx):

	if event is InputEventMouseButton  and event.pressed and event.button_index == BUTTON_LEFT:
		input_pickable = false
		var fire = get_node("/root/Main/Chaudron/ColorRect")
		if get_node("/root/Main").add_ingredient(6): #OK WTF (refer to enum in body_part)
			fire.material.set_shader_param("brighter_color", Color.green)
		else:
			fire.material.set_shader_param("brighter_color", Color.red)

		var tween = create_tween().set_trans(Tween.TRANS_BACK)

		get_node("/root/Main/Chaudron/FireAudio").play()

		tween.tween_property($FireHandle, "position", Vector2(0, 170), 0.5)

		tween.parallel().tween_property(fire, "rect_size:y", 350.0, 0.5)

		tween.tween_property($FireHandle, "position", Vector2(0, 0), 1.0)
		tween.parallel().tween_property(fire.material, "shader_param/brighter_color", Color.white, 0.75)
		tween.parallel().tween_property(fire, "rect_size:y", 300.0, 0.5)

		tween.tween_property(self, "input_pickable", true, 0.0)



func _process(delta):

	if wiggle:
		v += delta * s
	else:
		v -= delta * s

	v = clamp(v, 0.0, 10.0)

	$FireHandle.position.y = sin(OS.get_ticks_msec() * 0.001 * PI * 2.0) * v



func _on_FireHandle_mouse_entered():
	wiggle = true
	pass # Replace with function body.


func _on_FireHandle_mouse_exited():
	wiggle = false
	pass # Replace with function body.
