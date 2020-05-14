class Execution::Operation::UploadImages < Trailblazer::Operation
  step Model( Execution, :find_by )
  step :attach_images!

  def attach_images!(options, model:, params:, **)
    if params[:images].present?
      model.images.attach(params[:images])
    else
      Railway.fail!
    end
  end
end
