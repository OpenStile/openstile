module SizeMapHelper

  def generate_mapping relation, parent, children, category="numeric"
    parent_size = relation.find_by(name: parent, category: "alpha")
    children_sizes = children.map{|child| relation.find_by(name: child, category: category)}
    
    ret = {}
    unless parent_size.nil?
      ret[parent_size.id] = children_sizes.compact.map(&:id)
    end
    ret
  end

  def top_size_ids_map
    ret = {}
    ret.merge!(generate_mapping(TopSize, "XS", ["00","0","2"]))
    ret.merge!(generate_mapping(TopSize, "Small", ["2","4","6"]))
    ret.merge!(generate_mapping(TopSize, "Medium", ["6","8","10"]))
    ret.merge!(generate_mapping(TopSize, "Large", ["10","12","14"]))
    ret.merge!(generate_mapping(TopSize, "XL", ["14","16","18"]))

    ret
  end

  def bottom_size_ids_map
    numeric_map = {}
    numeric_map.merge!(generate_mapping(BottomSize, "XS", ["00","0","2"]))
    numeric_map.merge!(generate_mapping(BottomSize, "Small", ["2","4","6"]))
    numeric_map.merge!(generate_mapping(BottomSize, "Medium", ["6","8","10"]))
    numeric_map.merge!(generate_mapping(BottomSize, "Large", ["10","12","14"]))
    numeric_map.merge!(generate_mapping(BottomSize, "XL", ["14","16","18"]))

    inch_map = {}
    inch_map.merge!(generate_mapping(BottomSize, "XS", ("24".."26"), "inches"))
    inch_map.merge!(generate_mapping(BottomSize, "Small", ("25".."28"), "inches"))
    inch_map.merge!(generate_mapping(BottomSize, "Medium", ("27".."30"), "inches"))
    inch_map.merge!(generate_mapping(BottomSize, "Large", ("30".."33"), "inches"))
    inch_map.merge!(generate_mapping(BottomSize, "XL", ("32".."34"), "inches"))

    merged_map = {}
    numeric_map.each{|k,v| merged_map[k] = (v + inch_map[k]) unless inch_map[k].nil?}
    merged_map
  end

  def dress_size_ids_map
    ret = {}
    ret.merge!(generate_mapping(DressSize, "XS", ["00","0","2"]))
    ret.merge!(generate_mapping(DressSize, "Small", ["2","4","6"]))
    ret.merge!(generate_mapping(DressSize, "Medium", ["6","8","10"]))
    ret.merge!(generate_mapping(DressSize, "Large", ["10","12","14"]))
    ret.merge!(generate_mapping(DressSize, "XL", ["14","16","18"]))

    ret
  end
end
