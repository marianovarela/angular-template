'use strict'

angular.module('view.splash.controller.module', [])

.controller 'view.splash.controller',([
  '$scope'
  '$http'
  ($scope, $http) ->
    
    $scope.log = () ->
      console.log $scope.pin
    
    init = () ->
      config =
        method: 'POST'
        url: 'http://127.0.0.1:7777/oauth/device?type=device_code&client_id=1451611621832170&scope=user_posts'
        headers:{
          'Content-Type': 'application/x-www-form-urlencoded'
          }
      $http(config)
        .success (data) ->
          $scope.code = data.user_code
          console.log data
        .error (error) ->
          console.log error
        
    init()    
        
])