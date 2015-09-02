require 'rails_helper'

feature 'User visits blog' do

  before(:each) do
    @blogs_to_delete = []
  end

  after(:each) do
    @blogs_to_delete.each do |name|
      delete_test_blog name
    end
  end

  scenario 'and sees blogs' do
    create_test_blog('sample', title: 'A sample blog', author: 'Julia Frank', timestamp: '2015-09-01',
                     excerpt: 'A preamble to my awesome blog', content: 'Here it comes')

    given_i_navigate_to_the_blog_page
    expect(page).to have_text('A sample blog')
    expect(page).to have_text('Julia Frank')
    expect(page).to have_text('September 01, 2015')
    expect(page).to have_text('A preamble to my awesome blog')
    expect(page).to_not have_text('Here it comes')

    click_link 'A sample blog'

    expect(page).to have_text('Here it comes')
  end

  scenario 'and sees blog with long excerpt' do
    create_test_blog('sample', excerpt: 'a'*200)

    given_i_navigate_to_the_blog_page
    expect(page).to_not have_text('a'*200)
    expect(page).to have_text('a'*140 + '...')
  end

  scenario 'and sees only live blogs' do
    create_test_blog('live-blog-1', title: 'This is a live blog 1', live: true)
    create_test_blog('live-blog-2', title: 'This is a live blog 2', live: true)
    create_test_blog('draft-blog', title: 'This is a draft blog', live: false)

    given_i_navigate_to_the_blog_page
    expect(page).to have_text('This is a live blog 1')
    expect(page).to have_text('This is a live blog 2')
    expect(page).to_not have_text('This is a draft blog')
  end

  scenario 'and sees blogs sorted by date' do
    create_test_blog('new', title: 'Old', timestamp: '2015-09-01')
    create_test_blog('newer', title: 'Newer', timestamp: '2015-09-02')
    create_test_blog('newest', title: 'Newest', timestamp: '2015-09-03')

    given_i_navigate_to_the_blog_page
    expect(page.body.index('Newest')).to be < page.body.index('Newer')
    expect(page.body.index('Newer')).to be < page.body.index('Old')
  end

  def given_i_navigate_to_the_blog_page
    visit '/'
    click_link 'Blog', match: :first
  end

  private

  def create_test_blog(name, opts={})
    feature_dir = Rails.root.join('app', 'views', 'blog', 'test_featured')
    unless File.directory?(feature_dir)
      FileUtils.mkdir_p(feature_dir)
    end

    File.open(File.join(feature_dir, "#{name}.md"), 'w') do |file|
      file.puts("---")
      file.puts("title: \"#{opts[:title] || 'Sample Blog'}\"")
      file.puts("created_at: \"#{opts[:timestamp] || '2015-08-15'}\"")
      file.puts("author: \"#{opts[:author] || 'Jane Doe'}\"")
      unless opts[:live].nil?
        file.puts("live: #{opts[:live].to_s}")
      else
        file.puts("live: true")
      end
      file.puts("---")
      file.puts(opts[:excerpt] || "This is a blog written long ago")
      file.puts("[//]: # (more)")
      file.puts(opts[:content] || "And here is more content")
    end

    @blogs_to_delete << name
  end

  def delete_test_blog(name)
    File.delete(Rails.root.join('app', 'views', 'blog', 'test_featured', "#{name}.md"))
  end
end