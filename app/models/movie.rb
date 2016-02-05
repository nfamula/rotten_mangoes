class Movie < ActiveRecord::Base
  has_many :reviews
  mount_uploader :poster, MoviePosterUploader 

  scope :search, -> (key_word) { where(['title LIKE ? OR director LIKE ?', "%#{key_word}%", "%#{key_word}%"])}

  scope :runtime, -> (runtime_in_minutes) do
    case runtime_in_minutes #case has to refer back to the schema

    when "1"
     Movie.where(['runtime_in_minutes < 90'])
    
    when "2"
     Movie.where(['runtime_in_minutes 90...120'])

    when "3"
      Movie.where(['runtime_in_minutes > 120'])
    end
  end

  validates :title,
    presence: true

  validates :director,
    presence: true

  validates :runtime_in_minutes,
    numericality: { only_integer: true }

  validates :description,
    presence: true

  validates :release_date,
    presence: true

  validate :release_date_is_in_the_past

  def review_average
    if :rating_out_of_ten == nil
      puts "this movie has no reviews!"
    else
      reviews.sum(:rating_out_of_ten)/reviews.size
    end
  end

  protected

  def release_date_is_in_the_past
    if release_date.present?
      errors.add(:release_date, "should be in the past") if release_date > Date.today
    end
  end
end