'use strict'

angular.module('team.service.module', [
  #dependencies 
  #$injector from angular core
  'generic.repository.module'
])

.factory('team.service', [
  '$injector'
  'generic.service'
  'team.repository'
  ($injector, service, teamR) ->
    service(teamR).extend(
    
      transform: (raw) ->
        raw 
      
      get_by_tournament: (id) ->  this.promises \
        this.default_repository.task().get_by_tournament(id)
)])