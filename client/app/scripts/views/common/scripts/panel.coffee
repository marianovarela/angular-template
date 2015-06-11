'use strict'

angular.module('control.component.module')

.factory('navigable.panel.extender', [
  () ->
    opposite = 
      up: 'down'
      down: 'up'
      right: 'left'
      left: 'right'
      
    process_default_navigation:(navigable, config)->
      navigable.set_some_child = ->
        has_process = false
        last_action = @root().last_action
        move_from = opposite[last_action]
        for from_key, child_priority of config.from
          if move_from is from_key
            return @['set_' + child_priority + '_child']()
        if config.default 
          return @['set_' + config.default + '_child']()
        @set_first_child()
      
    process_default_navigation_string:(navigable, defaultNavigationString)->
      if defaultNavigationString
        @process_default_navigation navigable, JSON.parse defaultNavigationString.replace(/'/g, '"')
        
])

.factory('navigable.panel', [
  '$parse'
  'navigable.panel.extender'
  ($parse, extender) ->
    (component, $scope, $attrs) ->
      index = $attrs.priority
      if $attrs.priorityModel
        index = ($parse $attrs.priorityModel) $scope
      component.set_priority(index)
      extender.process_default_navigation_string component, $attrs.defaultNavigation
      component
])

.controller('navigable.vertical', [
  '$scope'
  '$attrs'
  'control.extensible.component'
  'navigable.panel'
  ($scope, $attrs, extensible, panel) ->
    $scope.navigable = panel(extensible.create_vertical($attrs.identifier), $scope, $attrs)
      .bind_to $scope
    
])

.controller('navigable.horizontal', [
  '$scope'
  '$attrs'
  'control.extensible.component'
  'navigable.panel'
  ($scope, $attrs, extensible, panel) ->
    $scope.navigable = panel(extensible.create_horizontal($attrs.identifier), $scope, $attrs)
      .bind_to $scope
    
])
