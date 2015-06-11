"use strict"


angular.module("background.service.module", [])

.factory("background.service",[
  '$rootScope'
  ($rootScope) ->
    
    default_option = 
      bodyclass: 'body-1'
    
    options = [
      bodyclass: 'body-2'
      paths: [
        'profile'
      ]
    ,
      bodyclass: 'body-3'
      paths: [
        'results'
        'newbet'
      ]
    ,
      bodyclass: 'body-4'
      paths: [
        'mybet'
      ]
    ]
    
    get_background = (path)->
      background = default_option
      for option in options
        for curPath in option.paths
           if path.indexOf(curPath) != -1
              background = option
      background

    initialize : () ->
      $rootScope.$on( "$routeChangeStart",
          (event, next, current) ->
            $rootScope.bodyclass = get_background(next.originalPath).bodyclass
        )
    
])