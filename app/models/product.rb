class Product < ApplicationRecord
  # is_impressionable :counter_cache => true
  is_impressionable :counter_cache => true, :column_name => :impressions_count, :unique => true

  belongs_to :user
  has_many :reviews

  def average_rating
    if self.reviews.present?
      review_score = reviews.map(&:rating).sum.to_i   #17 [5, 5, 3, 4]
      review_count = reviews.count                    #4 reviews
      (review_score/review_count).to_i                #4.25 (17/4)
    end
  end

end
