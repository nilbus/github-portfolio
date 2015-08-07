# Hold statistics for user contributions to a repository
class Stats
  include ValueObject.new(:user, :contribution_stats_response)
  alias_method :stats, :contribution_stats_response

  def commit_count_total
    return 0 unless stats
    stats.map { |stat| stat[:total] }.inject(:+)
  end
  memoize :commit_count_total

  def commit_count_user
    return 0 unless stats && user
    user_stats[:total]
  end
  memoize :commit_count_user

  def addition_count_total
    return 0 unless stats
    stats.map { |stat| addition_count_for_user_stats(stat) }.inject(:+)
  end
  memoize :addition_count_total

  def addition_count_user
    return 0 unless stats && user
    addition_count_for_user_stats(user_stats)
  end
  memoize :addition_count_user

  def inspect
    fields = %i(
      commit_count_total
      commit_count_user
      addition_count_total
      addition_count_user
    )
    attributes = Hash[fields.zip(fields.map { |field| send(field) })]
    "#<#{self.class.name} #{attributes.map { |f, v| "#{f}=#{v}" }.join(' ')}>"
  end

  private

  def user_stats
    stats.find { |stat| stat[:author][:login] == user.login }
  end

  def addition_count_for_user_stats(user_stats)
    user_stats[:weeks].map { |week| week[:a] }.inject(:+)
  end
end
