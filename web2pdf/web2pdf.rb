# require 'watir'
# require 'combine_pdf'

# is dependent on https://github.com/pdfkit/pdfkit/wiki/Installing-WKHTMLTOPDF
# require 'wkhtmltopdf-binary'

kit = PDFKit.new("https://google.com", :page_size => 'A4').to_file('output.pdf')