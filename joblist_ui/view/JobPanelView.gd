class_name  JobPanelView

extends Node

@export var options : OptionButton;
@export var jobDesc : Label;
@export var skillsContainer : GridContainer;
@export var skillLabel : PackedScene;

var currentSelectedJob : int = -1;

var presenter : JobPanelPresenter;

func _ready():
	presenter = JobPanelPresenter.new();
	options.item_selected.connect(on_option_selected);
	refresh();

func refresh() -> void :
	var classes = presenter.get_classes();

	#adding the options
	if classes.size() != options.item_count :
		options.clear();
		for job in classes:
			options.add_item(job);
	
	if currentSelectedJob == -1:
		currentSelectedJob = options.selected;
	
	var key = options.get_item_text(currentSelectedJob);
	var jobDetail = presenter.get_class_detail(key);
	
	if jobDetail.size() == 0:
		push_error("JobPanelView : there is no such key:"+key);
		return;
	
	jobDesc.text = jobDetail["description"];

	var skills = jobDetail["skills"].split(";",false);

	for oldObj in skillsContainer.get_children():
		oldObj.free();

	for skill in skills:
		var instance = skillLabel.instantiate();
		if(instance is SkillLabel):
			var label : SkillLabel = instance;
			label.set_text(skill);
			skillsContainer.add_child(label);
			label.resize_label();
	
func on_option_selected(option : int) -> void:
	currentSelectedJob = option;
	refresh();

	
	
