# Generated on 2016-02-02 using
# generator-skeletor 0.6.0

module.exports = ( grunt ) ->
  # show elapsed time at the end
  require( 'time-grunt' ) grunt
  # load all grunt tasks
  require( 'load-grunt-tasks' ) grunt

  # Project configuration.
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    config:
      app:      'app'
      dist:     'dist'

    watch:
      gruntfile: files: [ 'Gruntfile.coffee' ]

      sass:
        files: [ '<%= config.app %>/styles/**/*.{scss,sass}' ]
        tasks: [
          'sass:server'
          'autoprefixer:server'
          'bsReload:css'
        ]

      styles:
        files: [ '<%= config.app %>/styles/{,*/}*.css' ]
        tasks: [
          'copy:styles'
          'autoprefixer:server'
          'bsReload:css'
        ]

      coffee:
        files: [ '<%= config.app %>/scripts/{,*/}*.coffee' ]
        tasks: [
          'coffeelint'
          'coffee:dist'
          'replace:scripts'
        ]

      pages:
        files: [ '<%= config.app %>/{,*/}*.{html,php}' ]
        tasks: [
          'replace:pages'
        ]

    clean:
      dist:
        files: [
          dot: true
          src: [
            '<%= config.dist %>/*'
            '!<%= config.dist %>/.git*'
          ]
        ]
      server: [
        '.tmp'
      ]

    coffeelint:
      options:
        'max_line_length':
          'level': 'ignore'
        'no_empty_param_list':
          'level': 'error'
      files: [ '<%= config.app %>/scripts/{,*/}*.coffee' ]

    sass:
      options:
        sourcemap: 'inline'
        loadPath: [ '<%= config.app %>/bower_components' ]
      server:
        files: [
          expand: true
          cwd: '<%= config.app %>/styles'
          src: '**/*.{scss,sass}'
          dest: '.tmp/styles'
          ext: '.css'
        ]

    coffee:
      dist:
        options:
          sourceMap: true
          sourceRoot: ''
        files:
          '.tmp/scripts/<%= pkg.name %>.js': [ '<%= config.app %>/scripts/{,*/}*.coffee' ]

    autoprefixer:
      options:
        browsers: [ 'last 2 versions' ]
        map: true
      dist:
        files: [
          expand: true
          cwd: '<%= config.dist %>/styles'
          src: '**/*.css'
          dest: '<%= config.dist %>/styles'
        ]
      server:
        files: [
          expand: true
          cwd: '.tmp/styles'
          src: '**/*.css'
          dest: '.tmp/styles'
        ]

    copy:
      dist:
        files: [
          expand: true
          dot: true
          cwd: '<%= config.app %>'
          src: [
            'images/**/*'
            'fonts/**/*'
            '!**/_*{,/**}'
          ]
          dest: '<%= config.dist %>'
        ]
      styles:
        files: [
          expand: true
          dot: true
          cwd: '<%= config.app %>/styles'
          src: [ '**/*.css' ]
          dest: '.tmp/styles'
        ]
      faFontsServer:
        expand: true
        dot: true
        cwd: '<%= config.app %>/bower_components/font-awesome/fonts'
        dest: '.tmp/fonts'
        src: '*.{eot,svg,ttf,woff,woff2,otf}'
      faFontsDist:
        expand: true
        dot: true
        cwd: '<%= config.app %>/bower_components/font-awesome/fonts'
        dest: '<%= config.dist %>/fonts'
        src: '*.{eot,svg,ttf,woff,woff2,otf}'

    replace:
      options:
        silent: true
        patterns: [
          match: 'VERSION'
          replacement: '<%= pkg.version %>'
        ,
          match: 'DATE'
          replacement: '<%= grunt.template.today("yyyy-mm-dd") %>'
        ,
          match: 'NAME'
          replacement: '<%= pkg.name %>'
        ,
          match: 'YEAR'
          replacement: '<%= grunt.template.today("yyyy") %>'
        ,
          match: 'DESCRIPTION'
          replacement: '<%= pkg.description %>'
        ]
      scripts:
        files: [
          expand: true
          src: [ '.tmp/scripts/<%= pkg.name %>.js' ]
          dest: ''
        ]
      pages:
        files: [
          expand: true
          flatten: true
          src: [
            '<%= config.app %>/**/*.{html,php}'
            '!<%= config.app %>/bower_components/**/*.{html,php}'
          ]
          dest: '.tmp/'
        ]
      dist:
        files: [
          expand: true
          flatten: true
          src: [
            '<%= config.app %>/**/*.{html,php}'
            '!<%= config.app %>/bower_components/**/*.{html,php}'
          ]
          dest: '<%= config.dist %>'
        ]

    concat: {}

    uglify:
      options:
        banner: '/*! <%= pkg.name %> - v<%= pkg.version %> - <%= grunt.template.today("yyyy-mm-dd") %> */\n'

    cssmin:
      options:
        keepSpecialComments: 0
        banner: '/*! <%= pkg.name %> - v<%= pkg.version %> - <%= grunt.template.today("yyyy-mm-dd") %> */'
      dist:
        options:
          check: 'gzip'

    htmlmin:
      dist:
        options:
          collapseBooleanAttributes: true
          collapseWhitespace: true
          removeAttributeQuotes: true
          removeRedundantAttributes: true
        files: [
          expand: true
          cwd: '<%= config.dist %>'
          src: [ '**/*.html' ]
          dest: '<%= config.dist %>'
        ]

    imagemin:
      dist:
        options:
          progressive: true
          optimizationLevel: 3
        files: [
          expand: true
          cwd: '<%= config.app %>/images'
          src: '**/*.{jpg,jpeg,png}'
          dest: '<%= config.dist %>/images'
        ]

    useminPrepare:
      options:
        dest: '<%= config.dist %>'
      html: [
        '<%= config.dist %>/**/index.html'
      ]

    usemin:
      options:
        assetsDirs: '<%= config.dist %>'
      html: [ '<%= config.dist %>/**/*.html' ]
      css: [ '<%= config.dist %>/styles/**/*.css' ]

    bump:
      options:
        files: [
          'package.json'
          'bower.json'
        ]
        commitFiles: [
          'package.json'
          'bower.json'
        ]
        pushTo: 'origin'

    bsReload: css: 'screen.css'

    browserSync:
      options: open: false
      server:
        bsFiles: src: [
          '.tmp'
          '{<%= config.app %>}/bower_components/**/*.js'
          '{<%= config.app %>}/bower_components/**/*.{eot,svg,ttf,woff,woff2}'
          '<%= config.app %>/images/**/*.{gif,jpg,jpeg,png,svg,webp}'
        ]
        options:
          server: baseDir: [
            '.tmp'
            '<%= config.app %>'
          ]
          plugins: [
            module: 'bs-html-injector'
            options: files: './.tmp/**/*.html'
          ]
          watchTask: true
      dist: options: server: baseDir: '<%= config.dist %>'
      test:
        bsFiles: src: [
          '.tmp'
          '{<%= config.app %>}/bower_components/**/*.js'
          '<%= config.app %>/images/**/*.{gif,jpg,jpeg,png,svg,webp}'
        ]
        options:
          server: baseDir: [
            '.tmp'
            '<%= config.app %>'
          ]
          watchTask: true

    concurrent:
      server: [
        'sass:server'
        'coffee'
        'copy:styles'
        'copy:faFontsServer'
      ]
      dist: [
        'sass:server'
        'coffee'
        'copy:dist'
        'copy:faFontsDist'
      ]

  grunt.registerTask 'serve', ( target ) ->
    if target is 'dist'
      return grunt.task.run [
        'build'
        'browserSync:dist'
      ]

    grunt.task.run [
      'clean:server'
      'concurrent:server'
      'replace:pages'
      'replace:scripts'
      'autoprefixer:server'
      'browserSync:server'
      'watch'
    ]
    return

  grunt.registerTask 'build', [
    'clean'
    'replace:dist'
    'concurrent:dist'
    'replace:scripts'
    'useminPrepare'
    'concat'
    'autoprefixer:dist'
    'cssmin'
    'uglify'
    'imagemin'
    'usemin'
  ]

  grunt.registerTask 'default', [
    'coffeelint'
  ]

  return
