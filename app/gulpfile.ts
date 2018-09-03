import * as gulp from 'gulp'

const server = require('gulp-server-livereload')
const elm = require('gulp-elm')

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
  return gulp
    .src("_bundle")
    .pipe(server({
      livereload: true,
      port: 8787,
     // open: true
    }))
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

export default gulp.series(compileElm, assets, html, webserver, watch)