# Convert Octokit API responses into ValueObject/Entity objects
#
# rubocop:disable Style/ClassAndModuleChildren
#
class GithubAPI::ResponseObjectConverter
  def initialize(querying_user:)
    @querying_user = querying_user
  end

  # rubocop:disable Metrics/MethodLength
  def repo(response)
    Repo.new(
      full_name: response.full_name,
      name: response.name,
      description: response.description,
      created_at: response.created_at,
      fork: response.fork,
      owner: user(response.owner),
      primary_language: response.language,
      querying_user: @querying_user,
      star_count: response.stargazers_count,
      url: response.html_url,
    )
  end

  # rubocop:disable Metrics/AbcSize
  def issue(response, repo_full_name:, user_comment_count: nil, pr: nil)
    Issue.new(
      number: response.number,
      title: response.title,
      assigned_to: user(response.assignee),
      closed_by: user(response.closed_by),
      created_by: user(response.user),
      has_user_commentary: user_comment_count && user_comment_count > 0,
      pull_request: pr || response.pull_request.present?,
      repo: repo_full_name,
      state: response.merged_at ? 'merged' : response.state,
      url: response.html_url,
    )
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  def user(response_user)
    return nil unless response_user.present?
    User.new(login: response_user.login, name: response_user.name.presence)
  end

  def commit(response_commit)
    Commit.new(
      sha: response_commit.sha,
      author: user(response_commit.author),
      message: response_commit.commit.message,
      url: response_commit.html_url,
    )
  end
end
