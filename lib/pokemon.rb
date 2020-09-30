require_relative "../bin/environment.rb"
require_relative "../bin/sql_runner.rb"
require_relative "scraper.rb"

class Pokemon

    attr_accessor :name, :type, :db, :id

    def initialize(name:, type:, db:, id: nil)
        @name = name
        @type = type
        @db = db
        @id = id
    end

    def self.save(name, type, db)
        sql = <<-SQL
        INSERT INTO pokemon (name, type)
        VALUES (?, ?)
        SQL

        db.execute(sql, name, type)
        #@id = DB[:conn].execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
    end

    def self.find(id, db)
        sql = <<-SQL
        SELECT *
        FROM pokemon
        WHERE id = ?
        SQL
        result = db.execute(sql, id).flatten
        Pokemon.new(id: id, name: result[1], type: result[2], db: db)
      end
end
