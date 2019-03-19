class Song < ApplicationRecord
  validates :title, presence: true
  validates :title, uniqueness: { scope: [:artist_name, :release_year]}
  # validates :released, inclusion: {in: %w(true false)}
    validates :released, inclusion: {in: [true, false]}
    validates :artist_name, presence: true
  # validates :release_year, numericality: {less_than_equal_to: Date.today.year}
  # validates :release_year, presence: true, if: :released?
    validate :valid_release_year?

  def valid_release_year?
    return true unless released
    if release_year.to_s.empty?
      errors.add(:release_year, 'must be number')
    elsif release_year > Date.today.year
      errors.add(:release_year, 'must be in the past')
    end

    # 
    # with_options if: :released do |song|
    #     song.validates :release_year, numericality: { less_than_or_equal_to: Date.today.year }
    #     song.validates :release_year, presence: true
    #   end



  end
end
