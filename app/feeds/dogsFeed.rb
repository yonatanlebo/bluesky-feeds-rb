require_relative 'feed'

class DogsFeed < Feed
  REGEXPS = /כלב/,/פיד_כלבים/

  MUTED_PROFILES = [
  ]

  def feed_id
    5
  end

  def display_name
    'פיד כלבים'
  end

  def description
    "פיד כלבים"
  end

  def avatar_file
    "images/dog.png"
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