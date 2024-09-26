Dir[File.join(__dir__, 'feeds', '*.rb')].each { |f| require(f) }

require 'blue_factory'
require 'sinatra/activerecord'

ActiveRecord::Base.connection.execute "PRAGMA journal_mode = WAL"

BlueFactory.set :publisher_did, 'did:plc:7hn5x3dxhe5f43qbf3jm572h'
BlueFactory.set :hostname, 'feedgenerator.y-force.info'

# uncomment to enable authentication (note: does not verify signatures)
# see Feed#get_posts(params, visitor_did) in app/feeds/feed.rb
# BlueFactory.set :enable_unsafe_auth, true

BlueFactory.add_feed 'food-feed-he', FoodFeed.new
BlueFactory.add_feed 'cats-feed-he', CatsFeed.new
BlueFactory.add_feed 'birthday-he',  BirthdayFeed.new
BlueFactory.add_feed 'socks-feed-he',  SocksFeed.new
BlueFactory.add_feed 'dogs-feed-he',  DogsFeed.new
BlueFactory.add_feed 'chocolate-he',  ChocolateFeed.new
BlueFactory.add_feed 'knitting-he',  KnittingFeed.new
