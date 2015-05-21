class UploadController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only=>[:create_file]

  def show_list
    @files = FileUpload.paginate(:page=> params[:page] || 1, :per_page=> 10)
  end

  def create_file
    if FileUpload.handle_file params[:file]
      flash[:tip]= '上传成功'
      message='success'
    else
      flash[:tip]= '上传失败'
      message='fail'
    end

    render :json=>{:message=>message}
  end

end
