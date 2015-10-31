require Rails.root.join('app', 'models', 'blog', 'article.rb')

class Blog::Article
  def self.articles_path
    Rails.root.join('app', 'views', 'blog', 'test_featured').to_s
  end
end