require_relative 'feed'

class KnittingFeed < Feed
  REGEXPS = /סריגה/,/סורג/,/נסרוג/,/סרג/,/פידסריגה/,/פיד_סריגה/,/לסרוג/,/סורגים/,/סורגות/,/תפירה/,/תופר/,/תופרת/,/תופרים/,/\#פידסריגה/,/\#פידתפירה/

  MUTED_PROFILES = [
  ]

  def feed_id
    7
  end

  def display_name
    'פיד סריגה'
  end

  def description
    "פיד סריגה ותפירה וכל השאר"
  end

  def avatar_file
    "images/knitting.png"
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