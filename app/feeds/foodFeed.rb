require_relative 'feed'

class FoodFeed < Feed
  REGEXPS = /אוכל/,/אכלנו/,/נאכל/,/יאכלו/,/מזון/,/מסעדה/,/תאכל/,/ארוחת/,/אכילה/

  MUTED_PROFILES = [
  ]

  def feed_id
    1
  end

  def display_name
    "פיד אוכל"
  end

  def description
    "זה פיד אכלנים!"
  end

  def avatar_file
    "images/food.png"
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