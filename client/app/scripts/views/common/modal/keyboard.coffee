'use strict'

angular.module('view.common.modal.keyboard.controller.module', [])

.controller('view.common.modal.keyboard.controller', [
  '$scope'
  '$modalInstance'
  'keyboard.control'
  'control.root.component'
  'control.extensible.component'
  'container'
  ($scope, $modalInstance, control, root_component, extensible, container) ->
    
    modal_root = root_component('modal-keyboard-root')
    
    $modalInstance.result.finally ->
      control.unsubscribe modal_root
    
    control.subscribe modal_root
    
    $scope.navigable = extensible.create_vertical('modal-keyboard-main')
      .set_priority(2)
      .bind_to $scope, true
      
    $scope.container = container
    
    append_character = (character)->
      $scope.has_shift = false
      $scope.has_simbol = false
      $scope.container.text += character
    
    $scope.tap = (button)->
      append_character button.content
      
    $scope.tap_alphabetic = (button)->
      if $scope.has_shift
        append_character button.content.toUpperCase()
      else
        append_character button.content
      
    $scope.tap_special = (button)->
      if $scope.has_simbol
        append_character button.special
      else
        append_character button.content
      
    $scope.tap_space = -> append_character ' '
    
    $scope.shift = ->
      if $scope.has_shift
        $scope.has_shift = false 
      else
        $scope.has_shift = true 
        
    $scope.erase = ->
      $scope.container.text = $scope.container.text.slice(0, -1)
        
    $scope.simbol = ->
      if $scope.has_simbol
        $scope.has_simbol = false 
      else
        $scope.has_simbol = true 
      
    modal_root.add $scope.navigable
    
    $scope.resume = ->
      $modalInstance.dismiss()

    $scope.confirm = ->
      $modalInstance.close()
])

.controller('view.common.modal.keyboard.letters.controller', [
  '$scope'
  'control.extensible.component'
  'view.common.modal.keyboard.buttons'
  '$timeout'
  ($scope, extensible, buttons, $timeout) ->
    
    $scope.navigable = extensible.create_multiline('modal-letters-frame', 10)
      .set_priority(0)
      .bind_to $scope
      
    $scope.buttons = buttons
])

.factory('view.common.modal.keyboard.buttons', [
  () ->
    [
      { kind: 'KeyButtonSpecial', content: '1', special: '!' }
      { kind: 'KeyButtonSpecial', content: '2', special: '"' }
      { kind: 'KeyButtonSpecial', content: '3', special: '·' }
      { kind: 'KeyButtonSpecial', content: '4', special: '$' }
      { kind: 'KeyButtonSpecial', content: '5', special: '%' }
      { kind: 'KeyButtonSpecial', content: '6', special: '&' }
      { kind: 'KeyButtonSpecial', content: '7', special: '/' }
      { kind: 'KeyButtonSpecial', content: '8', special: '(' }
      { kind: 'KeyButtonSpecial', content: '9', special: ')' }
      { kind: 'KeyButtonSpecial', content: '0', special: '=' }
      { kind: 'Alphabetic', content: 'q'},
      { kind: 'Alphabetic', content: 'w'},
      { kind: 'Alphabetic', content: 'e'},
      { kind: 'Alphabetic', content: 'r'},
      { kind: 'Alphabetic', content: 't'},
      { kind: 'Alphabetic', content: 'y'},
      { kind: 'Alphabetic', content: 'u'},
      { kind: 'Alphabetic', content: 'i'},
      { kind: 'Alphabetic', content: 'o'},
      { kind: 'Alphabetic', content: 'p'},
      { kind: 'Alphabetic', content: 'a'},
      { kind: 'Alphabetic', content: 's'},
      { kind: 'Alphabetic', content: 'd'},
      { kind: 'Alphabetic', content: 'f'},
      { kind: 'Alphabetic', content: 'g'},
      { kind: 'Alphabetic', content: 'h'},
      { kind: 'Alphabetic', content: 'j'},
      { kind: 'Alphabetic', content: 'k'},
      { kind: 'Alphabetic', content: 'l'},
      { kind: 'Alphabetic', content: "ñ"},
      { kind: 'Alphabetic', content: 'z'},
      { kind: 'Alphabetic', content: 'x'},
      { kind: 'Alphabetic', content: 'c'},
      { kind: 'Alphabetic', content: 'v'},
      { kind: 'Alphabetic', content: 'b'},
      { kind: 'Alphabetic', content: 'n'},
      { kind: 'Alphabetic', content: 'm'},
      { kind: 'KeyButton', content: ','},
      { kind: 'KeyButton', content: '.'},
      { kind: 'KeyButton', content: '?'},
    ]
    
])







