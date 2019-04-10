  def upload_image(image_name, image_path, range)
    File.open("app/assets/images/#{image_name}_#{range}.png", "wb") { |f| f.write(Base64.decode64(image_path)) }

    Cloudinary::Uploader.upload("app/assets/images/#{image_name}_#{range}.png",
                               :folder => "crux/images", :public_id => "#{image_name}_#{range}", :overwrite => true,
                               :resource_type => "image"
    )
  end
