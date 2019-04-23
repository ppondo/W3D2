require_relative "questions_db_connection"


class QuestionLike
    def self.find_by_id(id)
        QuestionsDBConnection.instance.execute("SELECT * FROM question_likes WHERE question_likes.id = #{id}")
    end
end