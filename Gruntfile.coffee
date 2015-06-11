'use strict'

LIVERELOAD_PORT = 35729
lrSnippet = require('connect-livereload')(port: LIVERELOAD_PORT)

# var conf = require('./conf.'+process.env.NODE_ENV);
mountFolder = (connect, dir) ->
  connect.static require('path').resolve(dir)

# # Globbing
# for performance reasons we're only matching one level down:
# 'test/spec/{,*}*.js'
# use this if you want to recursively match all subfolders:
# 'test/spec/**/*.js'
module.exports = (grunt) ->
  require('load-grunt-tasks') grunt
  require('time-grunt') grunt
  # configurable paths
  yeomanConfig =
    project: 'app'
    app: 'client'
    dist: 'dist'
      
  grunt.loadNpmTasks('grunt-string-replace')
  grunt.loadNpmTasks('grunt-html-angular-validate')
      
  try
    yeomanConfig.app = require('./bower.json').appPath or yeomanConfig.app
  grunt.initConfig
    yeoman: yeomanConfig
    
    # watch: cada vez que un archivo cambia dentro de 'files' se ejecutan las 'task'
    watch:
      coffee:
        files: ['<%= yeoman.app %>/{<%= yeoman.project %>,common}/scripts/**/*.coffee']
        tasks: ['coffee:server']
      replace:
        files: ['<%= yeoman.app %>/<%= yeoman.project %>/views/**/*.html']
        tasks: ['string-replace:default']
      to_scss:
        files: ['<%= yeoman.app %>/<%= yeoman.project %>/styles/**/*.css']
        tasks: ['copy:css_as_scss', 'compass:server']
      compass:
        files: ['<%= yeoman.app %>/<%= yeoman.project %>/styles/**/*.{scss,sass}']
        tasks: ['compass:server']
          
      # watch.livereload: archivos que exigen la actualizacion de la pagina
      livereload:
        options:
          livereload: LIVERELOAD_PORT
        #no se incluyen 
        files: [
          '<%= yeoman.app %>/index.html'
          '.tmp/<%= yeoman.project %>/views/**/*.html'
          '.tmp/<%= yeoman.project %>/styles/css/*.{css,map}'
          '.tmp/<%= yeoman.project %>/scripts/**/*.js'
          '<%= yeoman.app %>/<%= yeoman.project %>/assets/images/**/*.{png,jpg,jpeg,gif,webp,svg}'
        ]
        
    # run web server
    connect:
      options:
        port: 9007
        # default 'localhost'
        # Change this to '0.0.0.0' to access the server from outside.
        hostname: "0.0.0.0"
      livereload:
        options:
          middleware: (connect) ->
            [lrSnippet, mountFolder(connect, '.tmp'), mountFolder(connect, yeomanConfig.app)]

    open:
      server:
        url: 'http://<%= connect.options.hostname %>:<%= connect.options.port %>'

    clean:
      dist:
        files: [
          dot: true
          src: ['.tmp', '<%= yeoman.dist %>/*', '!<%= yeoman.dist %>/.git*']
        ]
      server: '.tmp'

    compass:
        options:
          sassDir:                 '<%= yeoman.app %>/<%= yeoman.project %>/styles/scss'
          imagesDir:               '<%= yeoman.app %>/<%= yeoman.project %>/styles/images/'
          javascriptsDir:          '<%= yeoman.app %>/<%= yeoman.project %>/scripts'
          fontsDir:                '<%= yeoman.app %>/<%= yeoman.project %>/style/fonts'
          httpImagesPath:          '<%= yeoman.project %>/styles/images/'
          httpGeneratedImagesPath: '<%= yeoman.project %>/styles/images/'
          httpFontsPath:           '<%= yeoman.project %>/style/fonts'
          cssDir:                  '.tmp/<%= yeoman.project %>/styles/css'
          generatedImagesDir:      '.tmp/<%= yeoman.project %>/styles/images/'
          importPath: [
            '<%= yeoman.app %>/bower_components/'
            '.tmp/<%= yeoman.project %>/styles/legacy'
          ]
          relativeAssets: true
        dist:
          options:
            outputStyle: 'compressed'
            debugInfo: false
            noLineComments: true
        server:
          options:
            debugInfo: true
       
    coffee:
      server:
        options:
          sourceMap: true
          sourceRoot: ''
        files: [
          expand: true
          cwd: '<%= yeoman.app %>/<%= yeoman.project %>/scripts'
          src: '**/*.coffee'
          dest: '.tmp/<%= yeoman.project %>/scripts'
          ext: '.js'
        ,
          expand: true
          cwd: '<%= yeoman.app %>/common/scripts'
          src: '**/*.coffee'
          dest: '.tmp/common/scripts'
          ext: '.js'
        ]
      dist:
        options:
          sourceMap: false
          sourceRoot: ''
        files: [
          expand: true
          cwd: '<%= yeoman.app %>/<%= yeoman.project %>/scripts'
          src: '**/*.coffee'
          dest: '.tmp/<%= yeoman.project %>/scripts'
          ext: '.js'
        ,
          expand: true
          cwd: '<%= yeoman.app %>/common/scripts'
          src: '**/*.coffee'
          dest: '.tmp/common/scripts'
          ext: '.js'
        ]
    
    preprocess: 
      options:
        inline: true
        context :
          DEVELOP: true
      dist :
        src : '<%= yeoman.app %>/index.html'
        dest : '<%= yeoman.dist %>/index.html'

    useminPrepare:
      html: '<%= yeoman.app %>/index.html'
      options:
        dest: '<%= yeoman.dist %>'
        flow:
          steps:
            js: ['concat', 'uglifyjs']
            css: ['concat']
          post: []
    
    usemin:
      html: ['<%= yeoman.dist %>/**/*.html', '!<%= yeoman.dist %>/bower_components/**']
      css: ['<%= yeoman.dist %><%= yeoman.project %>/styles/**/*.css']
      options:
        dirs: ['<%= yeoman.dist %>']
    
    #resolver
    htmlmin:
      dist:
        options: 
          collapseWhitespace: true
          removeEmptyAttributes: true
          removeComments: true
          removeRedundantAttributes: true
        files: [
          expand: true
          cwd: '.tmp'
          src: ['*.html','<%= yeoman.project %>/views/**/*.html']
          dest: '<%= yeoman.dist %>'
        ]

    copy:
      bower_css_as_scss:
        files: [
          expand: true
          dot: true 
          flatten: true
          cwd: '<%= yeoman.app %>/bower_components/'
          dest: '.tmp/<%= yeoman.project %>/styles/legacy/css/bower/'
          src: [
            '**/*.css'
            '!**/{demo,demos,docs,doc}/**'
            ]
          rename: (dest, src) ->
            last_slash = src.lastIndexOf('/') + 1;
            directory = src.substring(0, last_slash);
            filename = src.substring(last_slash, src.lenght);
            dest + directory + '_' + filename.replace(/\.css$/, ".scss");
        ]
      css_as_scss:
        files: [
          expand: true
          dot: true
          cwd: '<%= yeoman.app %>/<%= yeoman.project %>/styles/css/'
          dest: '.tmp/<%= yeoman.project %>/styles/legacy/css/'
          src: [
            '**/*.css'
            ]
          rename: (dest, src) ->
            last_slash = src.lastIndexOf('/') + 1;
            directory = src.substring(0, last_slash);
            filename = src.substring(last_slash, src.lenght);
            dest + directory + '_' + filename.replace(/\.css$/, ".scss");
        ]
      images_from_bower_components_to_tmp:
        files: [
          expand: true
          dot: true 
          flatten: true
          cwd: '<%= yeoman.app %>/bower_components/'
          dest: '.tmp/<%= yeoman.project %>/styles/css/images'
          src: [
            '**/*.{png,gif,jpeg,jpg}'
            ]
        ]
      fonts_from_bower_components_to_tmp:
        files: [
          expand: true
          dot: true 
          flatten: true
          cwd: '<%= yeoman.app %>'
          dest: '.tmp/<%= yeoman.project %>/styles/fonts'
          src: [
            'bower_components/**/fonts/*'
            ]
        ]
      fonts_from_bower_components_to_dist:
        files: [
          expand: true
          dot: true 
          flatten: true
          cwd: '<%= yeoman.app %>'
          dest: '<%= yeoman.dist %>/<%= yeoman.project %>/styles/fonts'
          src: [
            'bower_components/**/fonts/*'
            ]
        ]
      not_processed_from_app_to_dist:
        files: [
          expand: true
          dot: true
          cwd: '<%= yeoman.app %>'
          dest: '<%= yeoman.dist %>'
          src: [
            'favicon.ico'
            'index.html'
            '<%= yeoman.project %>/assets/**/*'
            '<%= yeoman.project %>/styles/fonts/**/*'
            '<%= yeoman.project %>/styles/img/**/*'
            '<%= yeoman.project %>/styles/images/**/*'
            '<%= yeoman.project %>/data/**/*'
          ]
        ]
        
      styles_from_tmp_to_dist:
        expand: true
        cwd: '.tmp/<%= yeoman.project %>/styles'
        dest: '<%= yeoman.dist %>/<%= yeoman.project %>/styles/'
        src: '**/*.css'
        
      css_maps_from_bower_to_tmp: 
        files: [
          expand: true
          dot: true 
          flatten: true
          cwd: '<%= yeoman.app %>'
          dest: '.tmp/<%= yeoman.project %>/styles/css'
          src: [
            'bower_components/bootstrap/dist/css/bootstrap-theme.css.map'
            ]
        ]
        
      css_maps_from_bower_to_dist: 
        files: [
          expand: true
          dot: true 
          flatten: true
          cwd: '<%= yeoman.app %>'
          dest: '<%= yeoman.dist %>/<%= yeoman.project %>/styles/css'
          src: [
            'bower_components/bootstrap/dist/css/bootstrap-theme.css.map'
            ]
        ]
        
      maps_from_app_to_dist: #no es necesario actualmente?
        files: [
          expand: true
          dot: true 
          flatten: true
          cwd: '<%= yeoman.app %>'
          dest: '<%= yeoman.dist %>/<%= yeoman.project %>/scripts'
          src: [
            'bower_components/angular-animate/angular-animate.min.js.map'
            'bower_components/angular-cookies/angular-cookies.min.js.map'
            ]
        ]

    'string-replace': 
      default:
        files: [
          expand: true
          cwd: '<%= yeoman.app %>/<%= yeoman.project %>/views/'
          src: '**/*.html'
          dest: '.tmp/<%= yeoman.project %>/views/'
        ]
        options:
          replacements: [
            pattern: /<\$( )?(assets)( )?\$>/g
            replacement: '<%= yeoman.project %>/assets'
          ]

    htmlangular:
      server:
        options:
          tmplext: 'html'
          relaxerror: [
            'Element img is missing required attribute src.'
            'An img element must have an alt attribute, except under certain conditions. For details, consult guidance on providing text alternatives for images.'
            'Attribute href without an explicit value seen. The attribute may be dropped by IE7.'
            ]
        files:
          src: ['.tmp/<%= yeoman.project %>/views/**/*.html']

    concat:
      options:
        separator: grunt.util.linefeed + ';' + grunt.util.linefeed
      
    uglify:
      options:
        mangle: false

    concurrent:
      options:
        limit: 5
        logConcurrentOutput: true
      server: [
        'coffee:server'
        'string-replace:default'
        'compass:server'
        'copy:fonts_from_bower_components_to_tmp'
        'copy:images_from_bower_components_to_tmp'
        'copy:css_maps_from_bower_to_tmp'
        ]
      dist: [
        'coffee:dist'
        'string-replace:default'
        'compass:dist'
        'copy:styles_from_tmp_to_dist'
        'copy:fonts_from_bower_components_to_dist'
        'copy:css_maps_from_bower_to_dist'
        ]
      
  grunt.registerTask 'server', (target) ->
    init_tasks = ['clean:server', 'copy:css_as_scss', 'copy:bower_css_as_scss', 'concurrent:server']
    optional_task = []
    server_tasks = ['connect:livereload', 'open', 'watch']
    if target isnt 'lazy'
      optional_task.push 'htmlangular:server'
    grunt.task.run [].concat init_tasks, optional_task, server_tasks

  grunt.registerTask 'build', [
    'clean:dist'
    'useminPrepare'
    'copy:css_as_scss'
    'copy:bower_css_as_scss'
    'concurrent:dist'
    'copy:not_processed_from_app_to_dist'
    'copy:styles_from_tmp_to_dist'
    'concat:generated'
    'uglify:generated'
    'usemin'
    'htmlmin:dist'
    ]
  
  grunt.registerTask 'test', [
    'coffee:server'
    'jasmine'
    ]

  grunt.registerTask 'default', ['server']
