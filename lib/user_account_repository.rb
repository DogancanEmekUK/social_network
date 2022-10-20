require 'user_account'

class UserAccountRepository

    def all

        user_accounts = []

        sql = 'SELECT id, email, username FROM user_accounts;'

        result_set = DatabaseConnection.exec_params(sql, [])

        result_set.each do |record|
            user_account = UserAccount.new
            user_account.id = record['id']
            user_account.email = record['email']
            user_account.username = record['username']

            user_accounts << user_account
        end
        return user_accounts

    end

    def create(user_account)

        sql = 'INSERT INTO user_accounts(email, username) VALUES($1, $2);'
    
        params = [user_account.email, user_account.username]
    
        result_set = DatabaseConnection.exec_params(sql, params)

    end

    def find(id)

        user_accounts = []

        sql = 'SELECT id, email, username FROM user_accounts WHERE id = $1;'

        params = [id]

        result_set = DatabaseConnection.exec_params(sql, params)

        result_set.each do |record|
            user_account = UserAccount.new
            user_account.id = record['id']
            user_account.email = record['email']
            user_account.username = record['username']

            user_accounts << user_account
        end

        return user_accounts.map { |user| user.username }

    end

    def delete(id)

        sql = 'DELETE FROM user_accounts WHERE id = $1;'

        params = [id]

        DatabaseConnection.exec_params(sql, params)

    end

end