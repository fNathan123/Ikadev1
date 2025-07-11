class_name  JobPanelPresenter
extends RefCounted

var model : JobPanelModel;

func  _init() -> void:
	model = JobPanelModel.new();

func get_classes() -> Array:
	var classes = model.data_dictionary.keys();
	return classes;

func get_class_detail(key : String) -> Dictionary:
	if !model.data_dictionary.has(key):
		return {};
	
	var classDetail = model.data_dictionary[key];
	return classDetail;
