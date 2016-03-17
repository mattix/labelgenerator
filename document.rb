require 'prawn'
require 'json'

class Document
  def initialize(file)
    @data = JSON.parse(open(file).read)
    @font_size = @data["font_size"].nil? ? 10 : @data["font_size"]
    @columns = @data["columns"].nil? ? 2 : @data["columns"]
    @rows = @data["rows"].nil? ? 3 : @data["rows"]
    @gutter = @data["gutter"].nil? ? 10 : @data["gutter"]
    @pdf = Prawn::Document.new
  end

  def generate(output)
    @pdf.define_grid(:columns => @columns, :rows => @rows, :gutter => @gutter)
    for i in 0..(@columns * @rows - 1) do
      @pdf.grid((i / @columns).to_i, i % @columns).bounding_box do
        @pdf.text @data["date"], align: :center, size: @font_size
        @pdf.move_down(5 * @font_size)
        @pdf.text @data["title"], align: :center, size: @font_size * 2
        @pdf.move_down(10 * @font_size)
        @pdf.text "ABV: #{@data["abv"]}% IBU: #{@data["ibu"]} FG: #{@data["fg"]} OG: #{@data["og"]}", align: :center, size: @font_size
        @pdf.move_down @gutter * 2
      end
    end

    @pdf.render_file output
  end

  def font(custom_font)
    @pdf.font custom_font
  end

  def font_families
    @pdf.font_families
  end
end