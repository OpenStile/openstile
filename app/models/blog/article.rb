class Blog::Article
  include ActiveModel::Model
  attr_accessor :title, :content, :created_at, :permalink, :author, :live, :cover_photo

  # Used for ATOM-feed id
  def id
    @permalink.to_i
  end

  def content
    remove_yaml_frontmatter_from @content
  end

  def excerpt
    snipped = content.split('[//]: # (more)').first[0..139]
    if snipped.length == 140
      snipped = "#{snipped}..."
    end
    snipped
  end

  def has_more_text?
    content != excerpt
  end

  def created_at
    @created_at.to_date
  end

  def to_param
    @permalink.parameterize
  end

  # Query methods
  def self.all
    article_files.reverse.map do |file|
      self.new extract_data_from(file)
    end.sort_by(&:created_at).reverse
  end

  def self.all_live
    self.all.select do |file|
      file.live
    end
  end

  def self.find_by_name(name)
    file = find_file_by(name)
    self.new extract_data_from(file)
  end

  private
  def self.article_files
    sort_by_id Dir.glob(articles_path + '/' + '*.md')
  end

  def self.sort_by_id(files)
    files.sort_by { |x| File.basename(x, '.*').to_i }
  end

  def self.find_file_by(name)
    id = article_files.index { |x| x =~ /#{name}.md/ }
    article_files[id]
  end

  def self.articles_path
    Rails.root.join('app', 'views', 'blog', 'featured').to_s
  end

  # Content retrieval
  def self.extract_data_from(file)
    {
        content: File.read(file),
        permalink: File.basename(file, '.*')
    }.merge(yaml_frontmatter_metadata_from(file))
  end

  def self.yaml_frontmatter_metadata_from(file)
    YAML.load_file(file)
  end

  def remove_yaml_frontmatter_from(text)
    text.sub(/^\s*---(.*?)---\s/m, "")
  end

end