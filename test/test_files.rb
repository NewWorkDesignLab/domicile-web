module TestFiles
  # method `test_file` seems to be already taken by Rails::Generators::TestCase
  def sample_file(filename: 'test.jpg', type: 'image/jpg')
    Rack::Test::UploadedFile.new(Rails.root.join('test', 'files', filename), type)
  end

  def pdf_test_file(filename: 'test.pdf')
    sample_file(filename: filename, type: 'application/pdf')
  end

  def jpg_test_file(filename: 'test.jpg')
    sample_file(filename: filename)
  end

  def png_test_file(filename: 'test.png')
    sample_file(filename: filename, type: 'image/png')
  end
end
