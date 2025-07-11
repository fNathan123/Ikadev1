class_name JobPanelModel
extends RefCounted

var data_dictionary : Dictionary

func _init() -> void:
    var result = {};
    var file = FileAccess.open("res://class.csv", FileAccess.READ);
    
    if file:
        var headers = [];
        var line_num = 0;
        while not file.eof_reached():
            var line = file.get_line().strip_edges();
            if line == "":
                continue;
            
            var columns = line.split(",", false);
            
            if line_num == 0:
                headers = columns;
            else:
                var row_dict = {}
                for i in range(columns.size()):
                    row_dict[headers[i]] = columns[i];
                
                var key = columns[1];  # Use the first column as the key
                result[key] = row_dict;
            
            line_num += 1;
        
        file.close();
    else:
        push_error("Failed to open CSV file: res://class.csv");
    
    data_dictionary = result;
