class FileUpload < ActiveRecord::Base
  attr_accessible :name, :address, :file_type
  mount_uploader :file, FileUploader

  def self.handle_file file
    uploader = FileUploader.new
    uploader.store!(file)
    file_upload = create(:name=>file.original_filename, :address=>uploader.url, :file_type=> pick_type(file.original_filename))
    remote_upload file_upload
  end

  private

  def self.pick_type file_name
    type = file_name.split('.').last
    Constant::FILE_TYPE_LIST.select{|key,value| key if value.include?(type)}.keys.join
  end

  def self.remote_upload file_upload
    yaml = YAML.load(File.read(Rails.root.to_s+'/config/secrets.yml'))[Rails.env]
    aliyun_oss_id = yaml['aliyun_oss_id']
    aliyun_oss_secret = yaml['aliyun_oss_secret']
    CarrierWave::Storage::Aliyun::Connection.new({
      :storage=>'aliyun',
      :aliyun_access_id=> aliyun_oss_id,
      :aliyun_access_key=> aliyun_oss_secret,
      :aliyun_bucket=> 'qr-demo',
      :aliyun_internal=> false,
      :aliyun_area=>'cn-beijing'
    }).put(file_upload.name, File.open(Rails.root.to_s + '/public' + file_upload.address))
  end
end