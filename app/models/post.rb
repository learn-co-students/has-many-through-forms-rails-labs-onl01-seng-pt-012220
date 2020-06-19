class Post < ActiveRecord::Base
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :comments
  has_many :users, through: :comments

  def categories_attributes=(categories_hashes)   
    # {"0"=>{"name"=>"new category 1"}, "1"=>{"name"=>"new category 2"}} 

    categories_hashes.values.each do |category_attributes|
      # create a new category if this post doesn't already have this category
      #  find or create the category regardless of whether this post has it
      category = Category.find_or_create_by(category_attributes) unless category_attributes[:name] == ""
      # need to create a category that is already associated with this post
      # and need to make sure that this category already doesn't exist by name
      if category 
          self.categories << category
      end
    end
  end
end
