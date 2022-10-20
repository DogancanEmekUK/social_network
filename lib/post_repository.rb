require 'post'

class PostRepository

    def all
        posts = []

        sql = 'SELECT id, title, content, views, user_id FROM posts;'

        result_set = DatabaseConnection.exec_params(sql, [])

        result_set.each do |record|
            post = Post.new
            post.id = record['id']
            post.title = record['title']
            post.content = record['content']
            post.views = record['views']
            post.user_id = record['user_id']

            posts << post
        end
        return posts
    end

    def create(post)
        
        sql = 'INSERT INTO posts(title, content, views, user_id) VALUES($1, $2, $3, $4);'

        params = [post.title, post.content, post.views, post.user_id]

        result_set = DatabaseConnection.exec_params(sql, params)

    end

    def find(id)

        posts = []

        sql = 'SELECT id, title, content, views, user_id FROM posts WHERE id = $1;'

        params = [id]

        result_set = DatabaseConnection.exec_params(sql, params)

        result_set.each do |record|
            post = Post.new
            post.id = record['id']
            post.title = record['title']
            post.content = record['content']
            post.views = record['views']
            post.user_id = record['user_id']

            posts << post
        end
        return posts.map { |post| post.title }

    end

    def delete(id)

        sql = 'DELETE FROM posts WHERE id = $1;'

        params = [id]

        DatabaseConnection.exec_params(sql, params)

    end

end