class CardComponent < MountainView::Presenter
  properties :title, :description, :link, :image_url
  property :data, default: []
  property :foobar

  def title
    ["Foobar", properties[:title]].join(" - ")
  end

  def foobar
    h.content_tag(:p, "Foobar!!")
  end

  private

  def h
    ActionController::Base.helpers
  end
end
