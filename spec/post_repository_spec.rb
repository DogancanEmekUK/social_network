require 'post_repository'

RSpec.describe PostRepository do

    def reset_posts_table
        seed_sql = File.read('spec/post_seeds.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network' })
        connection.exec(seed_sql)
    end

    before(:each) do 
        reset_posts_table
    end

    it "returns all the posts" do
        repo = PostRepository.new
        result = repo.all
        expect(result.length).to eq 0
    end
    it "creates a new post" do
        repo = PostRepository.new
        post = Post.new
        post.title = 'Vacation'
        post.content = 'We had a lot of fun in Florida'
        post.views = '123'
        post.user_id = 1
        repo.create(post)
        result = repo.all
        expect(result.length).to eq 1
    end
    it "finds a post by the given id" do
        repo = PostRepository.new
        post = Post.new
        post.title = 'Vacation'
        post.content = 'We had a lot of fun in Florida'
        post.views = '123'
        post.user_id = 1
        repo.create(post)
        expect(repo.find(1)).to eq ['Vacation']
    end
    it "deletes a post by the given id" do
        repo = PostRepository.new
        post = Post.new
        post.title = 'Vacation'
        post.content = 'We had a lot of fun in Florida'
        post.views = '123'
        post.user_id = 1
        repo.create(post)
        repo.delete(1)
        expect(repo.all.length).to eq 0
    end

end