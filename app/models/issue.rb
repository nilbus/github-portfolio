# A GitHub Issue / Pull Request value object
class Issue
  include ValueObject.new(*%i(
    number
    title
    comments
    closed_by
    created_by
    pull_request
    repo
    state
    url
  ))
end
