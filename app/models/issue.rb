# A GitHub Issue / Pull Request value object
class Issue
  include ValueObject.new(*%i(
    number
    title
    closed_by
    created_by
    pull_request
    state
    url
  ))
end
