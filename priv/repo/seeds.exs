# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Blog.Repo.insert!(%Blog.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Blog.Repo
alias Blog.Posts.Post


# Seed posts
posts = [
  {"Crypto maxims", "Never roll your own crypto.", "crypto"},
  {"Fermat's penultimate theorem",
   "I have discovered a truly marvelous proof that P != NP, which this blog post is too narrow to contain",
   "math"},
  {"Phoenix is amazeballs", "1.3 Removed models!!!?!", "coding"}
]

for {title, body, category} <- posts do
  changeset = Post.changeset(%Post{title: title, body: body}, %{"categories" => category})
  Repo.insert!(changeset)
end
