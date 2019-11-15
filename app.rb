require 'bcrypt'
require 'date'

class App < Sinatra::Base

    enable :sessions

    before do 
        @db = SQLite3::Database.new('db/db.db')
        # @db.result_as_hash = true 
        # @time = Time.now.to_s
    end 

    get '/' do
        slim :index
    end 

    get '/user/?' do 
        @users = db.execute('SELECT users.*, users.name as username
            FROM users
            JOIN posts
            ON user.id = user_id;')
            slim :'users/user_profile' 
    end 

    post '/users' do 
        @db.execute('INSERT INTO users
            (name, age, email, id, role_id, img)
            VALUES(?,?,?,?,?,?',
            params['name'], params['age'], params['email'], params['id'], params['role_id'], params['img'])
        user_id = db.execute('SELECT id FROM users')

        redirect "/users/#{user_id}"
    end 

    get '/home' do 
        @user = @db.execute("SELECT * FROM users WHERE id = ?", 1)
        @followee = @db.execute("SELECT * FROM followings where follower_id = ?", 1) 
        homescreen_post = @db.execute("
            SELECT * FROM followings
            JOIN posted
            ON posted.by_user = followings.followee_id
            WHERE followings.follower_id = ?", 1)
    end 

    post '/register' do 
        username = params['username']
        plaintext = params['plaintext']
        pwdhash = BCrypt::Password.create(plaintext)
        @db.execute('INSERT INTO users (username, password) VALUES (?,?);', username, pwdhash)
        redirect '/'
    end 

    post '/login' do 
        username = params['username']
        plaintext = params['plaintext']

        pwdhash = @db.execute('SELECT password FROM users WHERE username = ?', username).first['password']
        bcrypt_hash = BCrypt::Password.new(pwdhash)

        if bcrypt_hash == plaintext
            redirect '/home'
        end 
    end 
end 