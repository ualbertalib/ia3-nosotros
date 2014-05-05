require 'json'
require 'curb'

metadata, path, accesskey, secret = ARGV

json = File.read(metadata)
text = JSON.parse(json)

text.each do |x|
	
	column = x['Column']
	tape = x['Tape #']
	format = x['Format of original']
	title = x['Episode title'].gsub(/.\(.+\)/, '')
	creator = x['Program Director']
	producer = x['Program Producer']
	description = x['Program Summary']
	recorddate = x['Episode Recording Date']
	playdate = x['Episode Play Date']
	subject = x['Keywords']

	if recorddate.match('unknown.+')
		date = playdate
	else
		date = recorddate
	end

	if File.exists?("#{path}/Tape\ #{column}\ test.mov")
		puts "uploading tape #{column} - #{title} from #{path}"

	Curl.put("http://s3.us.archive.org/programa-nosostros-#{column}/programa-nosotros-#{column}.mov") do |curl|
		curl.headers["x-amz-auto-make-bucket"] = 1
		curl.headers["authorization"] = "LOW #{accesskey}:#{secret}"
		curl.headers["x-archive-meta-mediatype"] = "movies"
		curl.headers["x-archive-meta01-collection"] = "nosotrostv"
		curl.headers["x-archive-meta-title"] = title
		curl.headers["x-archive-meta-creator"] = creator
		curl.headers["x-archive-meta-contributor"] = producer
		curl.headers["x-archive-meta-date"] = date
		curl.headers["x-archive-meta-recording_date"] = recorddate
		curl.headers["x-archive-meta-air_date"] = playdate
		curl.headers["x-archive-meta-description"] = description
		curl.headers["x-archive-meta01-subject"] = subject
		curl.put_data = File.read("#{path}/Tape\ #{column}\ test.mov")
		curl.verbose = true
	end

	else 
		puts "Nosotros tape #{column} file not available. Title: #{title} Path: #{path}"
	end

#subjects = subject.split(';')
#			i = 1
#			subjects.each do |x| 
#				x = x.strip
#				number = i.to_s
#				if number.length == 1
#					number = '0' + number
#				end  
#				i = i + 1
#			subjectheader = (prefix + number + '-subject')		
#			headers[subjectheader] = x
#			end			

end
