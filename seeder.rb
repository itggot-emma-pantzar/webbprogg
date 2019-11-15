require 'sqlite3'

class Seeder

    def self.seed!
        db = connect
        drop_tables(db)
        create_tables(db)
        # populate_tables(db)
    end

    def self.connect
        SQLite3::Database.new 'db/db.db'
    end

    def self.drop_tables(db)
        db.execute('DROP TABLE IF EXISTS comments;')
        db.execute('DROP TABLE IF EXISTS likes;')
        db.execute('DROP TABLE IF EXISTS saves;')
        db.execute('DROP TABLE IF EXISTS posted;')
        db.execute('DROP TABLE IF EXISTS user;')
        db.execute('DROP TABLE IF EXISTS userroles;')
        db.execute('DROP TABLE IF EXISTS followings;')
    end

    def self.create_tables(db)

        db.execute <<-SQL
            CREATE TABLE IF NOT EXISTS "comments" (
                "user"	INTEGER NOT NULL,
                "post"	INTEGER NOT NULL,
                "content"	TEXT NOT NULL,
                "time"	TEXT
            );
        SQL

        db.execute <<-SQL
            CREATE TABLE IF NOT EXISTS "likes" (
                "user"	INTEGER NOT NULL,
                "post"	INTEGER NOT NULL,
                "time"	INTEGER NOT NULL
            );
        SQL

        db.execute <<-SQL
            CREATE TABLE IF NOT EXISTS "saves" (
                "user_id"	INTEGER NOT NULL,
                "post_id"	INTEGER NOT NULL,
                "time"	TEXT NOT NULL
            );
        SQL

        db.execute <<-SQL
            CREATE TABLE IF NOT EXISTS "posted" (
                "by_user"	INTEGER NOT NULL,
                "post_id"	INTEGER UNIQUE,
                "time"	TEXT NOT NULL,
                PRIMARY KEY("post_id")
            );
        SQL

        db.execute <<-SQL
            CREATE TABLE IF NOT EXISTS "user" (
                "name"	TEXT NOT NULL UNIQUE,
                "email"	TEXT NOT NULL UNIQUE,
                "pwdhash"	TEXT,
                "id"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
                "age"	INTEGER NOT NULL
            );
        SQL

        db.execute <<-SQL
            CREATE TABLE IF NOT EXISTS "userroles" (
                "user_id"	INTEGER NOT NULL,
                "role_id"	INTEGER NOT NULL
            );
        SQL

        db.execute <<-SQL
            CREATE TABLE IF NOT EXISTS "followings" (
                "follower_id"	INTEGER,
                "followee_id"	INTEGER
            );
        SQL

    end

#     def self.populate_tables(db)
        
#         distributors = [
#             {name: "Kalles Cola", phone: "555-1234", email: "refill@kallescola.se"},
#             {name: "Lisas Läsk", phone: "555-2345", email: "service@lisaslask.se"},
#             {name: "Gunnars Gott", phone: "555-3456", email: "moar@gunnarsgott.se"},
#             {name: "Wolfgangs Wunderbara Waror", phone: "555-4567", email: "wulfie@www.se"}
#         ]
            
#         items = [
#             {name: "Coke 33cl", price: 25, distributor_id: 1},
#             {name: "Fanta 33cl", :price => 25, distributor_id: 2},
#             {name: "Sprite 33cl", price: 25, distributor_id: 2},
#             {name: "Salta Nappar", price: 15, distributor_id: 3},
#             {name: "Colanappar", price: 15, distributor_id: 3},
#             {name: "Ahlgrens Bilar", price: 15, distributor_id: 4},
#             {name: "Snickers", price: 10, distributor_id: 4},
#             {name: "Twix", price: 10, distributor_id: 4},
#             {name: "Mars", price: 10, distributor_id: 4}
#         ]

#         machines = [
#             {address: "Origovägen 4"},
#             {address: "Sven Hultins Gata 9C"},
#             {address: "Röntgenvägen 9"},
#             {address: "Grillkorvsgränd 3"},
#             {address: "Wavrinskys plats"}
#         ]

#         denominations = {200 => 10, 
#                          100 => 20,
#                          50 => 20,
#                          20 => 50,
#                          10 => 100, 
#                          5  => 200,
#                          2  => 0, 
#                          1  => 200}

        
#         distributors.each do |d| 
#             db.execute("INSERT INTO distributors (name, phone, email) VALUES(?,?,?)", d[:name], d[:phone], d[:email])
#         end        

#         items.each do |item| 
#             db.execute("INSERT INTO items (name, price, distributor_id) VALUES(?,?,?)", item[:name], item[:price], item[:distributor_id])
#         end

#         machines.each do |m| 
#             db.execute("INSERT INTO machines (address) VALUES(?)", m[:address])
#         end

#         machines.each_with_index do |_, machine|
#             denominations.each do |denomination, amount| 
#                 db.execute("INSERT INTO cash_depots (machine_id, denomination, amount) VALUES(?, ?, ?)", machine + 1, denomination, amount)
#             end
#         end

#         machines.each_with_index do |_, machine|
#             items.each_with_index do |_, item|
#                 db.execute("INSERT INTO stocks(machine_id, item_id, slot, amount) VALUES(?, ?, ?, ?)", machine + 1, item + 1, item + 1, rand(0..20))
#             end
#         end

#     end

# end

Seeder.seed!