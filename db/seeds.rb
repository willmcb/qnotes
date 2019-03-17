# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#

note_body_text = 'Etiam at egestas turpis. Lorem ipsum dolor sit amet, consectetur' \
                 ' adipiscing elit. Fusce cursus pulvinar quam, a eleifend purus lacinia' \
                 ' eu. Pellentesque viverra tincidunt posuere. '

note_body_text2 = 'Mauris eu interdum orci, et facilisis odio. Proin porta fermentum' \
                  ' massa, pellentesque tempus turpis maximus et. Aliquam erat volutpat. '

note_body_java = <<-FOO
\n
```java
public class Factorial
{
	public static void main(String[] args)
	{	final int NUM_FACTS = 100;
		for(int i = 0; i < NUM_FACTS; i++)
			System.out.println( i + "! is " + factorial(i));
	}

	public static int factorial(int n)
	{	int result = 1;
		for(int i = 2; i <= n; i++)
			result *= i;
		return result;
	}
}
```
FOO

note_body_ruby = <<-FOO
\n
```ruby
# Say hi to everybody
def say_hi
  if @names.nil?
    puts "..."
  elsif @names.respond_to?("each")
    # @names is a list of some kind, iterate!
    @names.each do |name|
      puts "Hello there"
    end
  else
    puts "Hello there!"
  end
end
```
FOO

user = User.create(username: "testuser",
                   email: "testuser@test.com",
                   password: "password" )

col1 = user.collections.create(name: "ruby")
col2 = user.collections.create(name: "java")

user.collections.create(name: "html")
user.collections.create(name: "scala")
user.collections.create(name: "algorithms")
user.collections.create(name: "rails")

t1 = user.tags.create(name: "ruby")
t2 = user.tags.create(name: "java")
t3 = user.tags.create(name: "programming")
t4 = user.tags.create(name: "computers")

user.notes.create(title: "This is a ruby note",
                  body: note_body_text + note_body_ruby + note_body_text2,
                  collection: col1,
                  tags: [t1, t3, t4])

user.notes.create(title: "This is a java note",
                  body: note_body_text2 + note_body_java + note_body_text,
                  collection: col2,
                  tags: [t2, t3])

user.notes.create(title: "This is another ruby note",
                  body: note_body_text2 + note_body_ruby + note_body_text + note_body_text2,
                  collection: col1,
                  tags: [t1, t3, t4])

user.notes.create(title: "This is another java note",
                  body: note_body_text + note_body_text2 + note_body_java + note_body_text,
                  collection: col2,
                  tags: [t2, t3])

