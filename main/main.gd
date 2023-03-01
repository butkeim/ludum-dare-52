extends Node2D

var current_ingredient = null
var ingredients_in_chaudron := []

var hp = 5
var current_recipe := 1
var so_far_so_good := true

enum {PigeonHead, PigeonFoot, PigeonWing, PigeonTail, FlowerHead, FlowerRoot, Fire}


func _ready():

	var tween = create_tween()

	tween.tween_callback($MagicBook, "go_on_table").set_delay(1.0)
	tween.tween_callback($Key, "follow_mouse").set_delay(1.5)

	$Camera2D/CanvasLayer/Fondu.material.set_shader_param("amount", 2.0)

func _unhandled_input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()


var recipe_1 = [[FlowerHead, FlowerRoot], [FlowerHead, FlowerRoot], [Fire]]
var tracker_1 = 0

func check_recipe_1():
	var return_v = true
	var i = null

	i = ingredients_in_chaudron.pop_back()
	return_v = return_v and (i == Fire)

	i = ingredients_in_chaudron.pop_back()
	return_v = return_v and (i == FlowerHead or i == FlowerRoot)

	i = ingredients_in_chaudron.pop_back()
	return_v = return_v and (i == FlowerHead or i == FlowerRoot)

	i = ingredients_in_chaudron.pop_back()
	return_v = return_v and  (i == null or i == Fire)

	if return_v:
		validate_recipe()

	return return_v

var recipe_2 = [[PigeonWing, PigeonTail], [PigeonWing, PigeonTail], [PigeonWing, PigeonTail], [Fire], [PigeonWing, PigeonTail], [PigeonWing, PigeonTail], [PigeonWing, PigeonTail], [Fire]]
var tracker_2 = 0

func check_recipe_2():
	var return_v = true
	var i = null

	i = ingredients_in_chaudron.pop_back()
	return_v = return_v and (i == Fire)

	i = ingredients_in_chaudron.pop_back()
	return_v = return_v and (i == PigeonWing or i == PigeonTail)
	i = ingredients_in_chaudron.pop_back()
	return_v = return_v and (i == PigeonWing or i == PigeonTail)
	i = ingredients_in_chaudron.pop_back()
	return_v = return_v and (i == PigeonWing or i == PigeonTail)

	i = ingredients_in_chaudron.pop_back()
	return_v = return_v and (i == Fire)

	i = ingredients_in_chaudron.pop_back()
	return_v = return_v and (i == PigeonWing or i == PigeonTail)
	i = ingredients_in_chaudron.pop_back()
	return_v = return_v and (i == PigeonWing or i == PigeonTail)
	i = ingredients_in_chaudron.pop_back()
	return_v = return_v and (i == PigeonWing or i == PigeonTail)

	i = ingredients_in_chaudron.pop_back()
	return_v = return_v and  (i == null or i == Fire)

	if return_v:
		validate_recipe()

	return return_v


var recipe_3 = [[FlowerHead], [FlowerHead], [FlowerHead], [Fire], [Fire], [PigeonFoot], [PigeonFoot], [Fire], [PigeonHead, PigeonTail, PigeonWing], [PigeonHead, PigeonTail, PigeonWing], [PigeonHead, PigeonTail, PigeonWing],  [PigeonHead, PigeonTail, PigeonWing], [Fire], [Fire]]
var tracker_3 = 0
func check_recipe_3():
	var return_v = true
	var i = null

	i = ingredients_in_chaudron.pop_back()
	return_v = return_v and (i == Fire)
	i = ingredients_in_chaudron.pop_back()
	return_v = return_v and (i == Fire)

	var t = 0
	i = ingredients_in_chaudron.pop_back()
	if i != null:
		t += i
	return_v = return_v and (i == PigeonHead or i == PigeonWing or i == PigeonTail)
	i = ingredients_in_chaudron.pop_back()
	if i != null:
		t += i
	return_v = return_v and (i == PigeonHead or i == PigeonWing or i == PigeonTail)
	i = ingredients_in_chaudron.pop_back()
	if i != null:
		t += i
	return_v = return_v and (i == PigeonHead or i == PigeonWing or i == PigeonTail)
	i = ingredients_in_chaudron.pop_back()
	if i != null:
		t += i
	return_v = return_v and (i == PigeonHead or i == PigeonWing or i == PigeonTail) and t == (PigeonWing + PigeonWing + PigeonTail)

	i = ingredients_in_chaudron.pop_back()
	return_v = return_v and (i == Fire)

	i = ingredients_in_chaudron.pop_back()
	return_v = return_v and (i == PigeonFoot)
	i = ingredients_in_chaudron.pop_back()
	return_v = return_v and (i == PigeonFoot)

	i = ingredients_in_chaudron.pop_back()
	return_v = return_v and (i == Fire)
	i = ingredients_in_chaudron.pop_back()
	return_v = return_v and (i == Fire)

	i = ingredients_in_chaudron.pop_back()
	return_v = return_v and (i == FlowerHead)
	i = ingredients_in_chaudron.pop_back()
	return_v = return_v and (i == FlowerHead)
	i = ingredients_in_chaudron.pop_back()
	return_v = return_v and (i == FlowerHead)

	i = ingredients_in_chaudron.pop_back()
	return_v = return_v and (i == null or i == Fire)

	if return_v:
		# WIN
		var n = $Camera2D/CanvasLayer/Fondu

		n.visible = true
		n.modulate = Color("#820D1C")
		yield(get_tree().create_timer(3.0), "timeout")
		var tween = $Camera2D/Arrow.swap_view()
		tween.tween_callback($MagicBook, "show_validate", [str(current_recipe)])
		tween.tween_property(n.material, "shader_param/amount", 0.0, 3.0).set_delay(2.0)
		tween.tween_property(n.get_parent().get_node("Win"), "visible", true, 0.0)
		tween.tween_property(n.get_parent().get_node("Win"), "visible", true, 0.0).set_delay(10.0)
		tween.tween_callback(get_tree(), "reload_current_scene")

	return return_v


func check_recipe():
	so_far_so_good = true
	var r = false
	if current_recipe == 1:
		r = check_recipe_1()
		tracker_1 = 0
	elif current_recipe == 2:
		r = check_recipe_2()
		tracker_2 = 0
	elif current_recipe == 3:
		r = check_recipe_3()
		tracker_3 = 0

	if !r:
		#take damage, LOSE
		take_damage()

	ingredients_in_chaudron.clear()

	return r


func validate_recipe():
	yield(get_tree().create_timer(3.0), "timeout")
	var t = $Camera2D/Arrow.swap_view()
	t.tween_callback($MagicBook, "show_validate", [str(current_recipe)])
	current_recipe += 1
	t.tween_callback($MagicBook, "show_page", [str(current_recipe)]).set_delay(2.0)

func add_ingredient(ing):
	
	if ing == Fire and !so_far_so_good:
		ingredients_in_chaudron.clear()
		so_far_so_good = true
		tracker_1 = 0
		tracker_2 = 0
		tracker_3 = 0

	ingredients_in_chaudron.append(ing)

	var r = false
	if current_recipe == 1 and so_far_so_good:
		for i in recipe_1[tracker_1]:
			r = r or (ing == i)
		if !r and ing == Fire and tracker_1 == 0:
			return false
		else:
			tracker_1 += 1
	elif current_recipe == 2 and so_far_so_good:
		for i in recipe_2[tracker_2]:
			r = r or (ing == i)
		if !r and ing == Fire and tracker_2 == 0:
			return false
		else:
			tracker_2 += 1
	elif current_recipe == 3 and so_far_so_good:
		for i in recipe_3[tracker_3]:
			r = r or (ing == i)
		if !r and ing == Fire and tracker_3 == 0:
			return false
		else:
			tracker_3 += 1

	so_far_so_good = r
	return r

func take_damage():
	var n = get_node("Hearts/Heart" + str(hp))
	
	var tween = create_tween().set_trans(Tween.TRANS_BACK)

	tween.tween_property(n, "position", n.position + Vector2(0, 150), 0.5).set_delay(4.0)
	
	hp -= 1

	if hp <= 0:
		#SHOW LOSE SCREEN

		n = $Camera2D/CanvasLayer/Fondu
		n.visible = true
		n.modulate = Color("#000000")
		tween.tween_property(n.material, "shader_param/amount", 0.0, 1.0).set_ease(Tween.EASE_OUT_IN)
		tween.tween_property(n.get_parent().get_node("Loose"), "visible", true, 0.0)
		tween.tween_property(n.get_parent().get_node("Loose"), "visible", true, 0.0).set_delay(5.0)
		tween.tween_callback(get_tree(), "reload_current_scene")

		return
