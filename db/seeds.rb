require 'random_data'

# Create Posts
50.times do
  Post.create!(
    title: RandomData.random_sentence,
    body: RandomData.random_paragraph
  )
end
posts = Post.all

# Create Comments
100.times do
  Comment.create!(
    post: posts.sample,
    body: RandomData.random_paragraph
  )
end

#Add unique post
1.times do
  Post.find_or_create_by!(
    title: "Lorem ipsum dolor sit amet",
    body: "Lorem ipsum dolor sit amet consectetur adipiscing elit ut dapibus quis dui."
  )
end

#Add unique comment
1.times do
  Comment.find_or_create_by!(
    post: posts[50],
    body: "This is the best comment in the world."
  )
end

puts "Seed finished"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
