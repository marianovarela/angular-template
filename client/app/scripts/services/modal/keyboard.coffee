'use strict'

angular.module('keyboard.modal.service.module', [])

.factory('keyboard.modal.service',[
  '$modal'
  'keyboard.control'
  ($modal, control) ->
    
    previous_level = -> control.previous_level()
    
    show_in_modal : (container)->
      control.create_level()
      modalInstance = $modal.open(
        windowClass: 'keyboard-dialog'
        templateUrl: 'app/views/common/modal/keyboard/main.html'
        controller: 'view.common.modal.keyboard.controller'
        resolve:
          container: () -> container
      )
      modalInstance.result.finally(previous_level)
      modalInstance
   
])
