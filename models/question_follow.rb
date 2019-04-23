require_relative "questions_db_connection"
require_relative "user"
require_relative "question"


class QuestionFollow
    attr_accessor :id, :question_id, :user_id
    def initialize(options)
        @id = options[0]["id"]
        @question_id = options[0]["question_id"]
        @user_id = options[0]["user_id"]
    end

    def self.find_by_id(id)
        data = QuestionsDBConnection.instance.execute("SELECT * FROM questions_follows WHERE question_follows.id = #{id}")
        QuestionFollow.new(data)
    end

    def self.followers_for_question_id(question_id)
        data = QuestionsDBConnection.instance.execute(<<-SQL, question_id)
        SELECT
            *
        FROM
            users
        JOIN
            questions_follows ON users.id = questions_follows.user_id
        JOIN
            questions ON questions.id = questions_follows.question_id
        WHERE
            questions.id = ?
        SQL

        followers = []
        data.each do |datum|
            followers.push(User.new([datum]))
        end

        followers
    end

    def  self.followed_questions_for_user_id(user_id)
        data = QuestionsDBConnection.instance.execute(<<-SQL, user_id)
        SELECT
            * 
        FROM
            questions
        JOIN
            questions_follows ON questions.user_id = questions_follows.id
        JOIN
            users ON questions_follows.user_id = users.id
        WHERE
            questions.user_id = ?
        SQL
        questions = []
        data.each do |datum|
            questions.push(Question.new([datum]))
        end

        questions
    end
end