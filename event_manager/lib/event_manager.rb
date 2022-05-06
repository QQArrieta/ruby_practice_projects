require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'
require 'date'

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5,"0")[0..4]
end

def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    ).officials
  rescue
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

def save_thank_you_letter(id,form_letter)
  Dir.mkdir('output') unless Dir.exist?('output')

  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

def clean_phone_numbers(homephone)
  homephone = homephone.to_s.gsub(/\D+/, "") 
  if homephone.length>11 && homephone.length<10
    "Invalid number"
  elsif homephone.length==11 && homephone.start_with?("1")
    homephone[1..10]
  elsif homephone.length==10
    homephone
  else
    "Invalid number"
  end 
end

def total_instances_in_array(array)
  array.reduce(Hash.new(0)) do |result, instances|
    result[instances] += 1
    result
  end
end
hourly_holder = []
daily_holder = []
puts 'EventManager initialized.'

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

template_letter = File.read('form_letter.erb')
erb_template = ERB.new template_letter

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  legislators = legislators_by_zipcode(zipcode)
  time = row[:regdate]
  time = DateTime.strptime(time, '%m/%d/%Y %k:%M')
  hourly_holder << time.hour
  daily_holder << time.wday

  form_letter = erb_template.result(binding)

  save_thank_you_letter(id,form_letter)
end

p total_instances_in_array(hourly_holder).sort_by { |hour, instances| hour }
p total_instances_in_array(daily_holder).sort_by { |day, instances| day }