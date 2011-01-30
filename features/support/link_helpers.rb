module LinkHelpers

  def within_link(link_title)
    link = Link.find_by_title! link_title
    within "li#link_#{link.id}" do
      yield
    end
  end

end

World(LinkHelpers)
