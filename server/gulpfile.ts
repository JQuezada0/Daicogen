import * as gulp from 'gulp'
import * as ts from 'gulp-typescript'
import * as sourcemaps from 'gulp-sourcemaps'
const gls = require('gulp-live-server')

const tsProject = ts.createProject('tsconfig.json')

export function buildTS () {
  return tsProject
    .src()
    .pipe(sourcemaps.init())
    .pipe(tsProject(ts.reporter.fullReporter()))
    .js
    .pipe(sourcemaps.write())
    .pipe(gulp.dest('build/'))
}

export function copyJSON () {
  return gulp.src(['./ormconfig.json']).pipe(gulp.dest('build'))
}

export function serve (cb: (val: any) => void) {
  const server = gls.new('build/index.js')
  server.start()

  gulp.watch(['./**/*.ts', '!gulpfile.ts'], buildTS)
  gulp.watch(['./ormconfig.json'], copyJSON)
}

export const compile = gulp.series(buildTS)

export default gulp.series(buildTS, copyJSON, serve)
