
var gulp = require('gulp')
  , coffee = require('gulp-coffee')
  , nodemon = require('gulp-nodemon')
  , concat = require('gulp-concat');

var sources = {
    libraries : 'src/lib/*.js',
       assets : ['assets/*/*', 'assets/*'],
        beans : [ 'src/shared.coffee'
                , 'src/world.coffee'
                , 'src/prompt.coffee'
                , 'src/vehicle.coffee'
                , 'src/taxi.coffee'
                , 'src/main.coffee']
};

gulp.task('compile', function() {
    return gulp.src(sources.beans)
        .pipe(concat('Deathcab.coffee'))
        .pipe(coffee())
        .pipe(gulp.dest('build/public/js'))
});

gulp.task('assets', function() {
    return gulp.src(sources.assets, { base: 'assets' })
        .pipe(gulp.dest('build/public'));
});

gulp.task('glue', function() {
    return gulp.src(sources.libraries)
        .pipe(concat('Libraries.js'))
        .pipe(gulp.dest('build/public/js'));
});

gulp.task('serve', function() {
    nodemon({ script: 'server.js' })
        .on('restart', function () {
          console.log('Server restarted!')
        })
});

gulp.task('watch', function() {
    gulp.watch(sources.beans, ['compile']);
    gulp.watch(sources.assets, ['assets']);
    gulp.watch(sources.libraries, ['glue']);
});

gulp.task('build'  , ['assets', 'glue', 'compile']);
gulp.task('develop', ['build', 'watch']);
gulp.task('default', ['build', 'serve']);