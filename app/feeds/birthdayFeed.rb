require_relative 'feed'

class BirthdayFeed < Feed
  REGEXPS = /יום הולדת/,/יומהולדת/

  MUTED_PROFILES = [
  ]

  def feed_id
    3
  end

  def display_name
    "פיד יום הולדת"
  end

  def description
    "זה פיד לאנשים שחוגגים יום הולדת!"
  end

  def avatar_file
    "images/birthday.png"
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