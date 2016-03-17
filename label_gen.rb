require './document.rb'

if ARGV[1].nil?
  puts "Give two arguments: data json file and output file "
  puts "For example:"
  puts "ruby label_gen.rb data.json output.pdf"
  exit
end

document = Document.new(ARGV[0])

# Set custom font
# http://prawnpdf.org/docs/0.11.1/Prawn/Document.html
#
# Comment out if no font change is needed
document.font_families.update(
  "Urban"=> {
    :normal => "./urban.ttf"
  }
)
document.font "Urban"

document.generate ARGV[1]