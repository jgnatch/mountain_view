class CardComponent < MountainView::Presenter
  def title
    ['Foobar', properties[:title]].join(' - ')
  end
end
