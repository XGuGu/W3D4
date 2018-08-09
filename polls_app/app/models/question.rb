# == Schema Information
#
# Table name: questions
#
#  id         :bigint(8)        not null, primary key
#  poll_id    :integer          not null
#  text       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Question < ApplicationRecord
  validates :poll_id, presence: true
  validates :text, presence: true

  belongs_to :poll,
    primary_key: :id,
    foreign_key: :poll_id,
    class_name: :Poll

  has_many :answer_choices,
    primary_key: :id,
    foreign_key: :question_id,
    class_name: :AnswerChoice

  has_many :responses,
    through: :answer_choices,
    source: :responses

  def results
    hash = {}
    resp = self.answer_choices.includes(:responses)
    resp.each do |r|
      hash[r.text] = r.responses.length
    end

    hash
  end

  def improved_results
    hash = {}
    result = Question
      .select('answer_choices.text, COUNT(responses.id) AS response_count')
      .left_outer_joins(:responses)
      .where(id: self.id)
      .group('answer_choices.text')

    result.each do |r|
      hash[r.text] = r.response_count
    end

    hash

    # SELECT answer_choices.text, COUNT(responses.id)
    # FROM questions
    # JOIN answer_choices ON questions.id = answer_choices.question_id
    # LEFT JOIN responses ON answer_choices.id = responses.answer_id
    # GROUP_BY answer_choices.text
  end
end
