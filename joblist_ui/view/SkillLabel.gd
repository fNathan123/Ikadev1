class_name SkillLabel

extends ColorRect

@export var label : Label;

func set_text(text : String) -> void:
	label.text = text;

func resize_label() -> void:
	await get_tree().process_frame;
	var min_size = Vector2(label.size.x + 30, 23);
	custom_minimum_size = min_size;
	update_minimum_size();
