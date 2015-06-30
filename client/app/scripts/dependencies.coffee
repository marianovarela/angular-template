'use strict'

angular.module('app', [
  
  'ngRoute'
  'angularLocalStorage'
  'ngDialog'
  'ui.bootstrap'
  
  'view.main.controller.module'
  
  #'promise.handler.module'
  #'generic.repository.module'
  #'generic.service.module'  
  #'cache.service.module'
  #'empty.object.module'
  #'attribute.loader.module'
  #'authentication.module'
  #'session.module'
  #'user.module'
     
  'view.splash.controller.module'
  
  'background.service.module'
  'feed.service.module'
  'resource.service.module'

  'view.popup.alert.controller.module'

])

.directive 'ngEnter', ->
  (scope, element, attrs) ->
    element.bind 'keydown keypress', (event) ->
      if event.which == 13 or event.keyCode == 13
        scope.$apply ->
          scope.$eval attrs.ngEnter, $event: event
          return
        event.preventDefault()
      return
    return
