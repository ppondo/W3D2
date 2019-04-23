require_relative "questions_db_connection"

class QuestionFollow
    def self.find_by_id(id)
        QuestionsDBConnection.instance.execute("SELECT * FROM questions_follows WHERE question_follows.id = #{id}")
    end
end