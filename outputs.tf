# output "origin_s3_bucket" {
#   value = [
#     for bucket in module.s3_bucket : bucket.bucket_id
#   ]
#   description = "Origin bucket name"
# }
