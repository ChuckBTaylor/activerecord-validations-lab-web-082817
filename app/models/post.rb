class ClickyValidator < ActiveModel::Validator
  PHRASES = [/Won't Believe/, /Secret/, /Guess/, /Top \d/]

  def validate(record)
    if record[:title]
      valid = PHRASES.map do |exp|
        record[:title].match(exp)
      end.any?
    else
      valid = false
    end
    unless valid
      record.errors[:title] << "Title is not click-baity enough"
    end
  end
end

class Post < ActiveRecord::Base
  validates :title, presence: true
  validates_with ClickyValidator, :fields=>:title
  validates :content, length: {minimum: 250}
  validates :summary, length: {maximum:250}
  validates :category, inclusion: { in: %w(Fiction Non-Fiction)}


end
