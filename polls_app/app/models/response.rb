# == Schema Information
#
# Table name: responses
#
#  id         :bigint(8)        not null, primary key
#  user_id    :integer          not null
#  answer_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Response < ApplicationRecord
  validates :user_id, presence: true
  validates :answer_id, presence: true
  validate :respondent_already_answered?
  validate :respondent_is_author

  belongs_to :respondent,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  belongs_to :answer_choice,
    primary_key: :id,
    foreign_key: :answer_id,
    class_name: :AnswerChoice

  has_one :question,
    through: :answer_choice,
    source: :question

  def sibling_responses
    self.question.responses.where.not(id: self.id)
  end



  private
  def not_duplicate_response
    answers = self.sibling_responses
    !(answers.exists?(user_id: self.user_id))
  end

  def respondent_already_answered?
    unless not_duplicate_response
      errors[:base] << 'You cannot answer the same question twice'
    end
  end

  def respondent_is_author
    if self.user_id == self.question.poll.author_id
      errors[:base] << 'You cannot answer your own question'
    end
  end


end
