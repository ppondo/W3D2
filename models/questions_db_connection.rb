require 'sqlite3'
require 'singleton'
#https://github.com/ppondo/W3D2.git

class QuestionsDBConnection < SQLite3::Database
    include Singleton

    def initialize
        super('questions.db')
        self.type_translation = true
        self.results_as_hash = true
    end
end