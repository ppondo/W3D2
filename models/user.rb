require_relative "questions_db_connection"
require_relative "question"
require_relative "reply"
class User
    attr_accessor :fname, :lname
    def self.all
        data = QuestionsDBConnection.instance.execute('SELECT * FROM users')
        data.map! { |datum| Users.new(datum) }
        data
    end

    def initialize(options)
        @id = options[0]["id"]
        @fname = options[0]["fname"]
        @lname = options[0]["lname"]
    end

    def self.find_by_id(id)
        data = QuestionsDBConnection.instance.execute("SELECT * FROM users WHERE users.id = #{id}")
        User.new(data)
    end

    def self.find_by_name(fname, lname)
        data = QuestionsDBConnection.instance.execute("SELECT * FROM users WHERE users.fname = ? AND users.lname = ?", fname, lname )
        User.new(data)
    end

    def authored_questions
        questions = Question.find_by_author_id(self.id)
        return questions
    end

    def authored_replies
        replies = Reply.find_by_user_id(self.id)
        return replies
    end

    protected
    attr_reader :id
end