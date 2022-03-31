resource aws_s3_bucket "b1"{
      bucket = "hsbc-sheshi2809"
      
}
resource aws_s3_bucket_policy "b1p1"{
	bucket =aws_s3_bucket.b1.bucket
	policy =file("./bpolicy.json")
}
resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.b1.id
  versioning_configuration {
    status = "Enabled"
  }
}