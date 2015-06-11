'use strict'

angular.module('view.main.controller.module', [])


.controller('view.main.controller', [
  '$scope'
  '$location'
  'ngDialog'
  ($scope, $location, ngDialog) ->
    
    $scope.goHome = ->
      $location.path ""

    $scope.goBack = ->
      window.history.back()

    $scope.goToProfile = ->
      $location.path('/game/profile')

    $scope.alert = (msg) ->
      $scope.alertMessage = msg
      opts = {
        backdrop: true
        backdropClick: true
        dialogFade: false
        keyboard: true
        templateUrl : 'prode/views/popup/alert.html'
        controller : 'view.popup.alert.controller'
        resolve: {}
        scope: $scope
      }
      ngDialog.open opts

])

.factory('view.main.keys', [
  () ->
    {
      ENTER:   13
      BACK:   166

      LEFT:    37
      UP:      38
      RIGHT:   39
      DOWN:    40

      RED:    398
      GREEN:  399
      YELLOW: 400
      BLUE:   401

      B:       66
      G:       71
      R:       82
      Y:       89

      V:       86
    }
    
])