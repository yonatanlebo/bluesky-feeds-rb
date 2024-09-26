require_relative 'feed'

class ChocolateFeed < Feed
  REGEXPS = /שוקו/,/שוקולד/,/קקאו/

  MUTED_PROFILES = [
  ]

  def feed_id
    6
  end

  def display_name
    'פיד שוקולד'
  end

  def description
    "הפיד הכי מתוק שיש פה, פיד שוקולד ומה שמכינים ממנו"
  end

  def avatar_file
    "images/chocolate.png"
  end

  def post_matches?(post)
    return false if MUTED_PROFILES.include?(post.repo)

    REGEXPS.any? { |r| post.text =~ r } && !(EXCLUDE.any? { |r| post.text =~ r })
  end

  def colored_text(t)
    text = t.dup

    EXCLUDE.each { |r| text.gsub!(r) { |s| Rainbow(s).red }}
    REGEXPS.each { |r| text.gsub!(r) { |s| Rainbow(s).green }}

    text
  end
end