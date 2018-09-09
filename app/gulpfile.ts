import * as gulp from 'gulp'

const elm = require('gulp-elm')
import * as connect from "gulp-connect"

export function compileElm () {
  return gulp
    .src('src/*.elm')
    .pipe(elm.bundle('elm.js'))
    .pipe(gulp.dest('_bundle/app/'))
}

export function html () {
  return gulp
    .src("index.html")
    .pipe(gulp.dest("_bundle/"))
}

export function webserver () {
  connect.server({
    root: '_bundle',
    host: "0.0.0.0",
    livereload: {
      port: 58493
    },
    port: 9000
  })
}

export function assets () {
  return gulp
    .src("assets/**")
    .pipe(gulp.dest("_bundle/assets/"))
}

function watch () {
  gulp.watch("src/**/*.elm", compileElm)
  gulp.watch("index.html", html)
  gulp.watch("assets/**/*.*", assets)
}

export default gulp.series(compileElm, assets, html, gulp.parallel(webserver, watch))