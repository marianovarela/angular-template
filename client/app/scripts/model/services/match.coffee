'use strict'

angular.module('match.service.module', [
  #dependencies 
  #$injector from angular core
  'generic.repository.module'
])

.factory('match.service', [
  '$injector'
  'generic.service'
  'match.repository'
  ($injector, service, matchR) ->
    service(matchR).extend(
    
      transform: (raw) ->
        raw     
        
)])