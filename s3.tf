resource "aws_s3_bucket" "bkt" {
  bucket = "${var.bucket_name}"
  tags = {
    Name        = "My bucket"
    Environment = "test"
  }
}

resource "aws_s3_bucket_acl" "website" {

  bucket = aws_s3_bucket.bkt.id
  acl    = var.website_bucket_acl
}


resource "aws_s3_bucket_policy" "website_bucket_policy" {
  bucket = aws_s3_bucket.bkt.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "PolicyForWebsiteEndpointsPublicContent",
  "Statement": [
    {
      "Sid": "PublicRead",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:*",
      "Resource": [
        "${aws_s3_bucket.bkt.arn}/*",
        "${aws_s3_bucket.bkt.arn}"
      ]
    }
  ]
}
POLICY
}

resource "aws_s3_bucket_website_configuration" "website" {

  bucket = aws_s3_bucket.bkt.id
 
  index_document {

    suffix = var.website_index_document
  }

  error_document {
    key = var.website_error_document
  }
}


resource "aws_s3_bucket_public_access_block" "website_bucket_public_access_block" {

  bucket                  = aws_s3_bucket.bkt.id
  ignore_public_acls      = false
  block_public_acls       = false
  restrict_public_buckets = false
  block_public_policy     = false
}

resource "aws_s3_bucket_object" "indexdoc" {
  bucket = aws_s3_bucket.bkt.id
  source = "./index.html"
  key = "index.html"
  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("./index.html")
  content_type = "text/html"
}