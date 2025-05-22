extends Node2D

class_name InventoryItem

var item_name: String = ""
var item_quantity : int = 0


func _ready():
	var rand_val = randi() % 5
	if rand_val == 0:
		item_name = "Activated_coal"
	elif rand_val == 1:
		item_name = "Filter_cotton"
	elif rand_val == 2:
		item_name = "Gas_mask"
	elif rand_val == 3:
		item_name = "Improved_mask"
	else:
		item_name = "Mini_oxygen"
		
	$TextureRect.texture = load("res://The_Alchemist_Quest/assets/gameDemo/" + item_name + ".png")
	var stack_size = int(JsonData.item_data.get(item_name, {}).get("StackSize", 1))
	item_quantity = randi() % stack_size + 1
	
	if stack_size == 1:
		$Label.visible = false
	else: 
		$Label.text = str(item_quantity)
		
func set_item(nm,qt):
	item_name = nm
	item_quantity = qt
	$Label.text = str(qt)
	$TextureRect.texture = load("res://The_Alchemist_Quest/assets/gameDemo/" + item_name + ".png")
	var stack_size = int(JsonData.item_data.get(item_name, {}).get("StackSize", 1))
	if stack_size == 1:
		$Label.visible = false
	else:
		$Label.visible = true
		$Label.text = str(item_quantity) 
	
func add_item_quantity(amount_to_add):
	item_quantity += amount_to_add
	$Label.text = str(item_quantity)
	
func decrease_item_quantity(amount_to_remove):
	item_quantity -= amount_to_remove
	$Label.text = str(item_quantity)
	
func try_add_quantity(amount):
	var stack_size = int(JsonData.item_data[item_name].get("StackSize",1))
	if item_quantity + amount <= stack_size:
		item_quantity += amount
		$Label.text = str(item_quantity)
		return true
	return false
	
signal item_right_clicked(item_name: String, item_description: String)

func _on_gui_input(event: InputEvent):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
		emit_signal("item_right_clicked", item_name, JsonData.item_data[item_name]["Description"])
	
	
