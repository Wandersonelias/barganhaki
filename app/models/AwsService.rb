class AwsService
    AWS_ID = AWS_ID
    AWS_KEY = AWS_KEY
    BUCKET = AWS_BUCKET
    
    def self.s3
    Aws::S3::Resource.new(
        credentials: Aws::Credentials.new(AWS_ID, AWS_KEY),
        region: 'sa-east-1'
    )
    end
    
    def self.upload(file, name)
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

    def image=(value)
        if value.is_a?(String)
        super(value)
        else
        super(AwsService.upload(value.tempfile.path, value.original_filename))
        end
    end
end 