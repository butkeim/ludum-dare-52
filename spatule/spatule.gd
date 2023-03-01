extends Area2D


var v = 0.0
var s = 50.0
var wiggle := false

func _ready():
	pass


func _input_event(viewport, event, shape_idx):

	if event is InputEventMouseButton  and event.pressed and event.button_index == BUTTON_LEFT:
		input_pickable = false
		var r = get_node("/root/Main").check_recipe()
		
		var tween = create_tween().set_trans(Tween.TRANS_BACK)
		
		var fire = get_node("/root/Main/Chaudron/ColorRect")
		
		tween.tween_property($Spatule, "position", Vector2(0, 500), 0.75)
		tween.tween_property(fire, "rect_size", Vector2(500, 100), 0.5)
		tween.parallel().tween_property($Spatule, "position", Vector2(0, -300), 1.0)
		tween.tween_property($Drink, "playing", true, 0.0)
		tween.tween_property(fire, "rect_size", Vector2(500, 300), 0.5)
		tween.parallel().tween_property($Spatule, "position", Vector2(0, 0), 2.5)
		tween.tween_property(self, "input_pickable", true, 0.0)
		
		if !r:
			tween.tween_property($Bad, "playing", true, 0.0)

func _process(delta):

	if wiggle:
		v += delta * s
	else:
		v -= delta * s

	v = clamp(v, 0.0, 10.0)

	$Spatule.position.y = sin(OS.get_ticks_msec() * 0.001 * PI * 2.0) * v


func _on_Spatule_mouse_entered():
	wiggle = true
	pass # Replace with function body.


func _on_Spatule_mouse_exited():
	wiggle = false
	pass # Replace with function body.
