'use strict'

angular.module('view.popup.alert.controller.module', [])

.controller 'view.popup.alert.controller', [
  '$routeParams'
  '$location'
  '$scope'
  'player.resource'
  'ngDialog'
  ($routeParams, $location, $scope, playerR, ngDialog) ->
    
    angular.element('#aceptar').focus()

    $scope.acepted = () ->
      ngDialog.close()

]

.controller('view.modal.controller', [
  '$scope'
  '$modalInstance'
  'control.extensible.component'
  'keyboard.control'
  'control.root.component'
  ($scope, $modalInstance, extensible, control, root_component) ->
    
    modal_root = root_component('favorite-team-success-main')
    
    $modalInstance.result.finally ->
      control.unsubscribe modal_root
    
    control.subscribe modal_root
    
    $scope.navigable = extensible.create_vertical('popup')
      .set_priority(2)
      .bind_to $scope, true
    
    modal_root.add $scope.navigable
    
    $scope.resume = ->
      $modalInstance.dismiss()

    $scope.confirm = ->
      $modalInstance.close()
      
])

.controller('view.modal.favorite.team.controller', [
  '$scope'
  '$modalInstance'
  'team'
  'control.extensible.component'
  'keyboard.control'
  'control.root.component'
  ($scope, $modalInstance, team, extensible, control, root_component) ->
    
    modal_root = root_component('favorite-team-success-main')
    
    $modalInstance.result.finally ->
      control.unsubscribe modal_root
    
    control.subscribe modal_root
    
    $scope.navigable = extensible.create_vertical('popup')
      .set_priority(2)
      .bind_to $scope, true
    
    $scope.team = team
    
    modal_root.add $scope.navigable
    
    $scope.resume = ->
      $modalInstance.dismiss()

    $scope.confirm = ->
      $modalInstance.close()
      
])

.controller('view.modal.generic.controller', [
  '$scope'
  '$modalInstance'
  'message'
  ($scope, $modalInstance, message) ->
    
    $scope.message = message
    
    $scope.resume = ->
      $modalInstance.dismiss()

    $scope.confirm = ->
      $modalInstance.close()
      
])
