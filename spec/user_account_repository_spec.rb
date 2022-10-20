require 'user_account_repository'

RSpec.describe UserAccountRepository do
    def reset_user_accounts_table
        seed_sql = File.read('spec/user_account_seeds.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network' })
        connection.exec(seed_sql)
    end

    before(:each) do 
        reset_user_accounts_table
    end

    it "returns all the users" do
        repo = UserAccountRepository.new
        expect(repo.all.length).to eq 0
    end
    it "creates a user" do
        repo = UserAccountRepository.new
        user_one = UserAccount.new
        user_two = UserAccount.new
        user_one.email = 'kadhfgksjf@gmail.com'
        user_one.username = 'kadhfgksjf'
        user_two.email = 'fgksjf@gmail.com'
        user_two.username = 'fgksjf'
        repo.create(user_one)
        repo.create(user_two)
        expect(repo.all.length).to eq 2
    end
    it "finds a user by the given id" do
        repo = UserAccountRepository.new
        user_one = UserAccount.new
        user_two = UserAccount.new
        user_one.email = 'kadhfgksjf@gmail.com'
        user_one.username = 'kadhfgksjf'
        user_two.email = 'fgksjf@gmail.com'
        user_two.username = 'fgksjf'
        repo.create(user_one)
        repo.create(user_two)
        expect(repo.find(2)).to eq ['fgksjf']
    end
    it "deletes a user by the given id" do
        repo = UserAccountRepository.new
        user_one = UserAccount.new
        user_two = UserAccount.new
        user_one.email = 'kadhfgksjf@gmail.com'
        user_one.username = 'kadhfgksjf'
        user_two.email = 'fgksjf@gmail.com'
        user_two.username = 'fgksjf'
        repo.create(user_one)
        repo.create(user_two)
        repo.delete(1)
        expect(repo.all.length).to eq 1
    end

end