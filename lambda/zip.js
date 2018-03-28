#!/usr/bin/env node

const {exec} = require('child_process')
const path = require('path')

// functions配下のlambdaをzipしてdist配下に放り込むスクリプト
exec('ls -d ./functions/*', (err, directories) => {
  if (err) return console.error(err)

  directories.split('\n').forEach(dir => {
    dir = dir.trim()
    if (!dir) return

    const basename = path.basename(dir)

    exec(`cd ${dir} && zip -r ../../dist/${basename}.zip *`, (err, stdout) => {
      if (err) return console.error(err)
      console.log(stdout);
    })
  })
})