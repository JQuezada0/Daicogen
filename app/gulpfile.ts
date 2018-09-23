import * as gulp from 'gulp'
import * as connect from "gulp-connect"
import * as browserify from "browserify"

const source = require("vinyl-source-stream")
const tsify = require("tsify")
const elm = require('gulp-elm')

export function compileElm () {
  return gulp
    .src('src/*.elm')
    .pipe(elm.bundle('index.js'))
    .pipe(gulp.dest('assets/js/elm'))
}

export function html () {
  return gulp
    .src("index.html")
    .pipe(gulp.dest("dist/"))
}

export function webserver () {
  connect.server({
    root: 'dist',
    host: "0.0.0.0",
    port: 9000
  })
}

export function img () {
  return gulp
  .src("assets/img/**")
  .pipe(gulp.dest("dist/assets/img"))
}

export function style () {
  return gulp
    .src("assets/style/**/*")
    .pipe(gulp.dest("dist/assets/style"))
}

export function fonts () {
  return gulp
    .src("assets/fonts/**/*")
    .pipe(gulp.dest("dist/assets/fonts"))
}

export function js () {
  return gulp
  .src("assets/js/lib/**/*")
  .pipe(gulp.dest("dist/assets/js/lib"))
}

const assets = gulp.parallel(img, style, fonts, js)

export function typescript () {
  return browserify({
    basedir: '.',
    debug: true,
    entries: ['assets/js/main.ts'],
    cache: {},
    packageCache: {}
})
  .plugin(tsify)
  .bundle()
  .pipe(source('main.js'))
  .pipe(gulp.dest("dist/assets/js"));
}

function watch () {
  gulp.watch("src/**/*.elm", gulp.series(compileElm, typescript))
  gulp.watch("index.html", html)
  gulp.watch("assets/**/*.*", assets)
  gulp.watch("assets/js/**/*.ts", typescript)
}

export default gulp.series(compileElm, typescript, assets, html, gulp.parallel(webserver, watch))