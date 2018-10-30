class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::Minimagick
  # Choose what kind of storage to use for this uploader:
  storage :aws
  # storage :fog

  process resize_to_fit: [200, 200]

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

end
