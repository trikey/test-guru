module FooterHelper
  def current_year
    Date.current.year
  end

  def github_url(author, repo)
    link_to author, repo, target: :_blank
  end
end
