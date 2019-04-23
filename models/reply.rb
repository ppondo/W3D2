require_relative "questions_db_connection"

class Reply

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
end