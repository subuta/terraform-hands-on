exports.handler = function (event, context, callback) {
  console.log('hello world!')
  console.log('event = ', event)
  console.log('process.env.foo = ', process.env.foo)
  console.log('context = ', context)
  callback(null, 'some success message')
}