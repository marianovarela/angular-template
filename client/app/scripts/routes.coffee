'use strict';

angular.module('app')

.config [
  '$routeProvider'
  ($routeProvider) ->
    $routeProvider
      .when(
        '/'
        templateUrl: 'app/views/splash.html'
        controller: 'view.splash.controller'
      )
      .otherwise redirectTo: '/'
      
]


