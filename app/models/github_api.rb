# Fetch data from the GitHub API.
#
# This class interfaces to a specific API gem implementation, and allows us to
# aggregate calls to fetch a single piece of information, when the API does not
# provide that information directly.
#
class GithubAPI
  def initialize(token: nil, cache: true)
    @api = Octokit::Client.new token: token
    configure_cache if cache
  end

  def user(github_username)
    response = @api.user(github_username)
    User.new(name: response.name, login: response.login)
  end

  private

  def configure_cache
    puts 'FIXME: Cache not implemented'
  end
end
