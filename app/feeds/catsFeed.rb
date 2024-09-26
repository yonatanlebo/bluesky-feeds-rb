require_relative 'feed'

class CatsFeed < Feed
  REGEXPS = /חתול/,/חתלתול/,/פיד_חתולים/

  MUTED_PROFILES = [
  ]

  def feed_id
    2
  end

  def display_name
    "פיד חתולים"
  end

  def description
    "חתולים! הם חתולים! זה פיד לחתולים!"
  end

  def avatar_file
    "images/cats.png"
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