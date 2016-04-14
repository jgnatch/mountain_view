class CardComponent < MountainView::Presenter
  include ActionView::Helpers::TagHelper
  
  properties :title, :description, :link, :image_url, :location
  property :data, default: []

  def title
    [location, properties[:title]].compact.join(", ")
  end
  
  def has_description?
    description.present?
  end
end
