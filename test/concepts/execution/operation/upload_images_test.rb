require 'test_helper'

class Execution::Operation::UploadImagesTest < ActiveSupport::TestCase
  test 'should append images to execution' do
    assert_equal 0, Execution.count
    assert_equal 0, ActiveStorage::Attachment.count
    assert my_execution = create_execution

    assert_difference 'ActiveStorage::Attachment.count' do
      assert params = ActionController::Parameters.new({
        id: my_execution[:id],
        images: [png_test_file]
      })
      assert result = Execution::Operation::UploadImages.(
        params: params
      )
      assert result.success?
      assert model = result[:model]
      assert_equal 1, model.images.count
    end

    assert_equal 1, Execution.count
    assert_equal 1, ActiveStorage::Attachment.count

    assert params = ActionController::Parameters.new({
      id: my_execution[:id],
      images: [png_test_file, png_test_file, png_test_file]
    })
    assert result = Execution::Operation::UploadImages.(params: params)
    assert result.success?

    assert_equal 4, result[:model].images.count
    assert_equal 1, Execution.count
    assert_equal 4, ActiveStorage::Attachment.count
  end
end
