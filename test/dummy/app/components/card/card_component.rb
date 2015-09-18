class CardComponent < MountainView::Presenter
  attributes :title, :description, :link, :image_url
  attribute :data, default: []
  attribute :foobar

  def title
    ['Foobar', properties[:title]].join(' - ')
  end

  def foobar
    h.content_tag(:p, "Foobar!!")
  end
end
