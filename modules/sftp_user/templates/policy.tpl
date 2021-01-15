{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListAllMyBuckets",
                "s3:GetBucketLocation"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "s3:ListBucket",
            "Resource": "arn:aws:s3:::${bucket}",
            "Condition": {
                "StringLike": {
                    "s3:prefix": [
                        "",
                        "${username}/*"
                    ]
                }
            }
        },
        {
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": [
                "arn:aws:s3:::${bucket}/${username}",
                "arn:aws:s3:::${bucket}/${username}/*"
            ]
        }
    ]
}