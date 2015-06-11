'use strict'

angular.module('bet.service.module', [
  #dependencies 
  #$injector from angular core
  'generic.repository.module'
])

.factory('bet.service', [
  '$injector'
  'generic.service'
  'bet.repository'
  ($injector, service, betR) ->
    service(betR).extend(
    
      implemented: () ->
        #nothing      
)])