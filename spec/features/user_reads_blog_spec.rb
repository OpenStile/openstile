require 'rails_helper'

feature 'User visits blog' do
  before(:all) do
    seed_blog_posts
  end

  after(:all) do
    delete_blog_posts
  end

  let(:blog_older){ Blog::Article.find_by_name('sample-blog-older') }
  let(:blog_newer){ Blog::Article.find_by_name('sample-blog-newer') }
  let(:blog_draft){ Blog::Article.find_by_name('sample-blog-draft') }

  scenario 'and sees excerpts from live blogs' do
    given_i_navigate_to_the_blog_page
    then_i_should_see_an_excerpt_for blog_older
    then_i_should_see_an_excerpt_for blog_newer
    then_i_should_not_see_an_excerpt_for blog_draft
    then_the_blog_ordering_should_be blog_newer, blog_older
  end

  scenario 'and reads a featured piece' do
    given_i_navigate_to_the_blog_page
    click_link 'A newer blog post'
    expect(page).to have_text('This is a blog written recently')
    expect(page).to have_text('And here is more content')
  end

  def given_i_navigate_to_the_blog_page
    visit '/'
    click_link 'Blog', match: :first
  end

  def then_i_should_see_an_excerpt_for blog
    expect(page).to have_text(blog.title)
    expect(page).to have_text("#{blog.author} | #{blog.created_at.strftime('%B %d, %Y')}")
    expect(page).to have_text(blog.excerpt)
    expect(page).to_not have_text('And here is more content')
  end

  def then_i_should_not_see_an_excerpt_for blog
    expect(page).to_not have_text(blog.title)
    expect(page).to_not have_text("#{blog.author} | #{blog.created_at.strftime('%B %d, %Y')}")
    expect(page).to_not have_text(blog.excerpt)
  end

  def then_the_blog_ordering_should_be first, second
    expect(page.body.index(first.excerpt.gsub("\n", ''))).to be < (page.body.index(second.excerpt.gsub("\n", '')))
  end

  private

  def seed_blog_posts
    File.open(Rails.root.join('app', 'views', 'blog', 'featured', 'sample-blog-older.md'), 'w') do |file|
      file.puts("---")
      file.puts("title:  \"An older blog post\"")
      file.puts("created_at: \"2015-08-15\"")
      file.puts("author: \"Jane Doe\"")
      file.puts("live: true")
      file.puts("---")
      file.puts("This is a blog written long ago")
      file.puts("[//]: # (more)")
      file.puts("And here is more content")
    end

    File.open(Rails.root.join('app', 'views', 'blog', 'featured', 'sample-blog-newer.md'), 'w') do |file|
      file.puts("---")
      file.puts("title:  \"A newer blog post\"")
      file.puts("created_at: \"2015-08-30\"")
      file.puts("author: \"Alice Johnson\"")
      file.puts("live: true")
      file.puts("---")
      file.puts("This is a blog written recently")
      file.puts("[//]: # (more)")
      file.puts("And here is more content")
    end

    File.open(Rails.root.join('app', 'views', 'blog', 'featured', 'sample-blog-draft.md'), 'w') do |file|
      file.puts("---")
      file.puts("title:  \"A draft blog post\"")
      file.puts("created_at: \"2015-09-01\"")
      file.puts("author: \"Dolly Martin\"")
      file.puts("live: false")
      file.puts("---")
      file.puts("This is a blog that's not ready")
      file.puts("[//]: # (more)")
      file.puts("And here is more content")
    end
  end

  def delete_blog_posts
    File.delete(Rails.root.join('app', 'views', 'blog', 'featured', 'sample-blog-older.md'))
    File.delete(Rails.root.join('app', 'views', 'blog', 'featured', 'sample-blog-newer.md'))
    File.delete(Rails.root.join('app', 'views', 'blog', 'featured', 'sample-blog-draft.md'))
  end
end