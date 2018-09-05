import * as gulp from 'gulp'
import * as childProcess from 'child_process'
import * as ts from 'gulp-typescript'
import * as util from 'util'
import * as sourcemaps from 'gulp-sourcemaps'
// tslint:disable-next-line:no-duplicate-imports
import { ExecException } from 'child_process'
const gls = require('gulp-live-server')

const exec: any = util.promisify(childProcess.exec)

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

export function copyGraphQL () {
  return gulp.src('./**/*.graphql').pipe(gulp.dest('build'))
}

export function copyJSON () {
  return gulp.src(['./ormconfig.json']).pipe(gulp.dest('build'))
}

export function serve (cb: (val: any) => void) {
  const server = gls.new('build/index.js');
  server.start()
}

export function watch () {
  gulp.watch('./src/**/*.ts', buildTS)
  gulp.watch('./src/**/*.graphql', copyGraphQL)
}

export const compile = gulp.series(buildTS, copyGraphQL)

export default gulp.series(buildTS, copyGraphQL, copyJSON, gulp.parallel(serve, watch))
