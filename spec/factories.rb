Factory.sequence :username do |n|
  "username-#{n}"
end

Factory.define :user do |user|
  user.username { Factory.next :username }
  user.password 'password'
  user.password_confirmation 'password'
end

Factory.define :link do |link|
  link.title 'Carbon Five'
  link.url 'http://www.carbonfive.com'
end

Factory.define :vote do |vote|
  vote.association :user, :factory => :user
  vote.association :link, :factory => :link
  vote.value 0
end