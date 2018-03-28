const AWS = require('aws-sdk')

exports.handler = function (event, context, callback) {
  const s3 = new AWS.S3()

  const params = {
    Bucket: `terraform-hands-on-bucket-${process.env.Environment}`,
    Key: 'current-date.txt',
    Body: (new Date()).toString()
  }

  s3.putObject(params, function (err, data) {
    // an error occurred
    if (err) {
      console.log(err, err.stack)
      return callback(err)
    }

    // successful response
    console.log(data)

    callback(null, 'some success message')
  })
}