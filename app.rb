require 'bcrypt'
require 'date'

class App < Sinatra::Base

    enable :sessions

    before do 
        @db = SQLite3::Database.new('db/db.db')
        # @db.result_as_hash = true 
        # @time = Time.now.to_s
    end 

    get '/?' do
        slim :index
    end 

    # get '/login' do 
    #     username= params['username']
    #     plaintext= params['plaintext']

    #     pwdhash = @db.execute('SELECT pwdhash FROM users WHERE username = ?', username)
    #     bcrypt_hash = BCrypt::Password.new(pwdhash)
    # end 

    # get '/register' do 
    #     @db.execute('INSERT INTO users 
    #     username, age, email, id, role_id VALUES(?,?,?,?,?)',
    #     params['name'], params['age'], params['email'], params['id'], params['role_id'])
    # end 

    # post '/login' do 


    #     if bcrypt_hash == plaintext
    #         redirect '/home'
    #     end 
    # end 

    get '/' do
        # visar användaren som nyss loggat in 
    end

    get '/user/:id' do
        # visa user_profile
        @user = @db.execute("SELECT * FROM users WHERE id = ?", params['id'])
        @posts = @db.execute('SELECT * FROM posted WHERE by_user = ?', params['id'])
             
        # @i=0
        # while @i <= @posts.length

            slim :'users/user_profile'
        # end
             
    end 
    
    post '/user/:id' do 
        @db.execute('INSERT INTO users
            (name, age, email, id, role_id, img)
            VALUES(?,?,?,?,?,?',
            params['name'], params['age'], params['email'], params['id'], params['role_id'], params['img'])
        user_id = db.execute('SELECT id FROM users')

        redirect "/users/user_profile/#{user_id}"
    end 

    get 'user/#{user_id}' do
        # visa user_profile
        @users = db.execute('SELECT users.*, users.name as username
            FROM users
            JOIN posts
            ON user.id = user_id;')
            slim :'users/user_profile' 
    end 

    get '/home' do 
        # visa hemskärm för user
        @user = @db.execute("SELECT * FROM users WHERE id = ?", 1)
        @followee = @db.execute("SELECT * FROM followings where follower_id = ?", 1) 
        @homescreen_post = @db.execute("
            SELECT * FROM followings
            JOIN posted
            ON posted.by_user = followings.followee_id
            WHERE followings.follower_id = ?", 1)
    end 

    post '/post' do 
    #    skapar en ny post

    end 

    get '/post' do 
        # visar den nya posten
    end 

    # post '/register' do 
    #     username = params['username']
    #     plaintext = params['plaintext']
    #     pwdhash = BCrypt::Password.create(plaintext)
    #     @db.execute('INSERT INTO users (username, password) VALUES (?,?);', username, pwdhash)
    #     redirect '/'
    # end 

    # get 'user' do
    # # visr den nya användaren
    # end


end 