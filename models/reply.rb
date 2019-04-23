require_relative "questions_db_connection"
require_relative "user"
class Reply
    attr_accessor :id, :question_id, :reply_id, :user_id, :body
    def initialize(options)
        @id = options[0]["id"]
        @question_id = options[0]["question_id"]
        @reply_id = options[0]["reply_id"]
        @user_id = options[0]["user_id"]
        @body = options[0]["body"]
    end

    def self.find_by_id(id)
        data = QuestionsDBConnection.instance.execute("SELECT * FROM replies WHERE replies.id = #{id}")
        Reply.new(data)
    end

    def self.find_by_user_id(user_id)
        replies = []

        data = QuestionsDBConnection.instance.execute("SELECT * FROM replies WHERE replies.user_id = #{user_id}")
        data.each do |datum|
            replies.push(Reply.new([datum]))
        end

        replies
    end

    def self.find_by_question_id(question_id)
        data = QuestionsDBConnection.instance.execute("SELECT * FROM replies WHERE replies.question_id = #{question_id}")
        Reply.new(data)
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

    def question
        data = QuestionsDBConnection.instance.execute(<<-SQL, self.question_id)
        SELECT 
            *
         FROM 
            questions
        WHERE 
            questions.id = ? 
        SQL

        return Question.new(data)
    end

    def parent_reply
        data = QuestionsDBConnection.instance.execute(<<-SQL, self.reply_id)
        SELECT 
            *
         FROM 
            replies
        WHERE 
            replies.id = ? 
        SQL

        return data.empty? ? self : Reply.new(data)
    end

    def child_replies
        data = QuestionsDBConnection.instance.execute(<<-SQL, self.id)
        SELECT 
            *
         FROM 
            replies
        WHERE 
            replies.reply_id = ? 
        SQL

        return data.empty? ? [] : Reply.new(data)
    end
end