'use strict'

angular.module('view.splash.controller.module', [])

.controller 'view.splash.controller',([
  '$scope'
  'feed.service'
  ($scope, feedS) ->
    
    init = () ->
      $scope.loadButonText = 'Load'
      $scope.feedSrc = 'http://www.telam.com.ar/rss2/politica.xml'
      $scope.loadFeed()  
        
    $scope.loadFeed = (e) ->
      console.log $scope.feedSrc
      feedS.parseFeed($scope.feedSrc).then (res) ->
        #$scope.loadButonText = angular.element(e.target).text()
        $scope.feeds = res.data.responseData.feed.entries
        console.log $scope.feeds
  
    init()    
        
])