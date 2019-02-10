# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create(username: "willtwo", email: "willtwo@test.com", password: "password" )

col1 = user.collections.create(name: "ruby")
user.collections.create(name: "java")
user.collections.create(name: "html")
user.collections.create(name: "scala")
user.collections.create(name: "algorithms")
user.collections.create(name: "rails")

user.notes.create(title: "test note", body: "this is the body", collection: col1)

t1 = Tag.create(name: "ruby")
t2 = Tag.create(name: "python")

user.notes.create(title: "test note two", body: "this is the body again", collection: col1, tags: [t1, t2])

Tag.create(name: "python")
Tag.create(name: "golang")
