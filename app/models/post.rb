class Post < ActiveRecord::Base
  has_paper_trail

  rails_admin do
    edit do
      field :name
      field :content
    end
  end
end
