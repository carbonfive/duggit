module VoteHelpers

  def within_link(link)
    within("#link-#{link}") { yield }
  end

  def within_vote(link, vote)
    within_link(link) do
      within(".vote") { within(".#{vote}") { yield } }
    end
  end

end

World(VoteHelpers)

