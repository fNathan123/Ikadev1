class_name  JobPanelView

extends Node

@export var options : OptionButton;
@export var job_desc : Label;
@export var skills_container : GridContainer;
@export var skill_label : PackedScene;

var curren_selected_job : int = -1;

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
	
	if curren_selected_job == -1:
		curren_selected_job = options.selected;
	
	var key = options.get_item_text(curren_selected_job);
	var jobDetail = presenter.get_class_detail(key);
	
	if jobDetail.size() == 0:
		push_error("JobPanelView : there is no such key:"+key);
		return;
	
	job_desc.text = jobDetail["description"];

	var skills = jobDetail["skills"].split(";",false);

	for oldObj in skills_container.get_children():
		oldObj.free();

	for skill in skills:
		var instance = skill_label.instantiate();
		if(instance is SkillLabel):
			var label : SkillLabel = instance;
			label.set_text(skill);
			skills_container.add_child(label);
			label.resize_label();
	
func on_option_selected(option : int) -> void:
	if curren_selected_job != option:
		curren_selected_job = option;
	refresh();

	
	
