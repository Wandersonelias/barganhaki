require "mini_magick"

class AwsService
    AWS_ID = AWS_ID
    AWS_KEY = AWS_KEY
    BUCKET = AWS_BUCKET
    
    def self.s3
        Aws::S3::Resource.new(
            credentials: Aws::Credentials.new(AWS_ID, AWS_KEY),
            region: 'us-east-1'
        )
    end
    
    def self.upload(file, name, crop=nil)
        if crop
            #resize image
            image = MiniMagick::Image.open(file)
            image.quality 95
            image.resize crop#
            image.auto_orient
            image.write file
        
            #crop image
            image = MiniMagick::Image.open(file)
            image.crop "#{crop}+0+0"
            image.write file
        end
        debugger
        obj = s3.bucket(BUCKET).object("#{Time.now.to_i}-#{name}")
        obj.upload_file(file, acl:'public-read')
        obj.public_url
    end
    
    def self.delete(path_file)
        bucket = s3.bucket(BUCKET)
        bucket.objects.each do |file|
            file.delete if(file.key == File.basename(path_file))
        end
    end
end 

#AWS_ACCESS_KEY_ID="AKIAJBIHKW46GWAOBOCQ" AWS_SECRET_ACCESS_KEY="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" S3_BUCKET_NAME ="barganha-images" rails s

#heroku config:set S3_BUCKET_NAME="barganha-images"
#heroku config:set AWS_ACCESS_KEY_ID="AKIAJBIHKW46GWAOBOCQ"
#heroku config:set AWS_SECRET_ACCESS_KEY="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"
#heroku config:set AWS_REGION="us-east-1"
