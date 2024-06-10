#!C:\Ruby32-x64\bin\ruby.exe

# создание един. объекта подключения.
require 'mysql2'
client = Mysql2::Client.new(
	:host     => '127.0.0.1',
	:username => 'root',
	:password => '',
	:database => 'bank',
	:encoding => 'utf8'
	)

# обработка значений из формы.
require "cgi"
cgi = CGI.new
if cgi['last-name'] != '' && cgi['name'] != '' && cgi['family-name'] != '' && cgi['passport'] != '' && cgi['itn'] != '' && cgi['insurance-number'] != '' && cgi['driving-license'] != '' && cgi['other-docs'] != '' && cgi['notes'] != ''
	client.query("INSERT INTO individuals (lastname, firstname, familyname, passport, itn, insurance, driverslicense, otherdocs, notes) VALUES (\""+cgi['last-name']+"\",\""+cgi['name']+"\",\""+cgi['family-name']+"\",\""+cgi['passport']+"\",\""+cgi['itn']+"\",\""+cgi['insurance-number']+"\",\""+cgi['driving-license']+"\",\""+cgi['other-docs']+"\",\""+cgi['notes']+"\")")
end
		
# главная функция для показа строк, работает всегда.
def viewSelect(client)
	results = client.query("SHOW COLUMNS FROM individuals")
	puts '<tr>'
	results.each do |row|
	  puts '<td>'+row['Field'].to_s+'</td>'
	end
	puts '</tr>'

	results = client.query("SELECT * FROM individuals ORDER BY id DESC")
	results.each do |row|
	  puts '<tr><td>'+row['id'].to_s+'</td><td>'+row['lastname']+'</td><td>'+row['firstname']+'</td><td>'+row['familyname']+'</td><td>'+row['passport'].to_s+'</td><td>'+row['itn'].to_s+'</td><td>'+row['insurance'].to_s+'</td><td>'+row['driverslicense'].to_s+'</td><td>'+row['otherdocs']+'</td><td>'+row['notes']+'</td><td>'+row['loaner_id'].to_s+'</td></tr>'
	end
end

# подпись.
def viewVer(client)
	results = client.query("SELECT VERSION() AS ver")
	results.each do |row|
	  puts row['ver']
	end
end

# чтение шаблона и отображение на экране.
puts "Content-type: text/html\n\n"
File.readlines('select.html').each do |line|

	s = String.new(line)
	s.gsub!(/[^0-9A-Za-z @]/, '')

	if s != "@tr" && s != "@ver"
		puts(line)
	end
	if s == "@tr"
		viewSelect(client)
	end
	if s == "@ver"
		viewVer(client)
	end
end