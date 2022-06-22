output "website_root_s3_bucket" {
  description = "The website root bucket where resources are uploaded"
  value       = aws_s3_bucket.bkt.bucket
}

output "website_redirect_s3_bucket" {
  description = "The s3 bucket of the website redirect bucket"
  value       = aws_s3_bucket.bkt.bucket
}

output "website_bucket_website_endpoint" {
  description = "The website endpoint, if the bucket is configured with a website. If not, this will be an empty string."
  value       = aws_s3_bucket.bkt.website_endpoint
}