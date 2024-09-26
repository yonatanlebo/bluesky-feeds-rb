require_relative 'feed'

class SocksFeed < Feed
  REGEXPS = /גרביים/,/פיד_גרביים/

  MUTED_PROFILES = [
  ]

  def feed_id
    4
  end

  def display_name
    "פיד גרביים"
  end

  def description
    "איפה שיש רגליים יש פיד גרביים"
  end

  def avatar_file
    "images/socks.png"
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