class Post

	include DataMapper::Resource

	property :id, Serial
	property :content, Text
	property :time, String

end