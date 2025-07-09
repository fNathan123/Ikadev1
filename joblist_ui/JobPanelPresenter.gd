class_name  JobPanelPresenter

var model : JobPanelModel;

func  _init() -> void:
	model = JobPanelModel.new();

func get_classes() -> Array:
	var classes = model.dataDictionary.keys();
	return classes;

func get_class_detail(key : String) -> Dictionary:
	if !model.dataDictionary.has(key):
		return {};
	
	var classDetail = model.dataDictionary[key];
	return classDetail;
