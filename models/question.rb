require_relative "questions_db_connection"
require_relative 'user'

class Question
    attr_accessor :id, :title, :body, :user_id
    def initialize(options)
        @id = options[0]["id"]
        @title = options[0]["title"]
        @body = options[0]["body"]
        @user_id = options[0]["user_id"]
    end

    def self.find_by_id(id)
        data = QuestionsDBConnection.instance.execute("SELECT * FROM questions WHERE questions.id = #{id}")
        Question.new(data)
    end
    
    def self.find_by_author_id(user_id)
        questions = []
        data = QuestionsDBConnection.instance.execute("SELECT * FROM questions WHERE questions.user_id = #{user_id}")
        data.each do |datum|
            questions.push(Question.new([datum]))
        end

        questions
    end

    def author
        data = QuestionsDBConnection.instance.execute(<<-SQL, self.user_id)
        SELECT 
            *
         FROM 
            users 
        WHERE 
            users.id = ? 
        SQL

        return User.new(data)
    end
end


