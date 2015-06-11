'use strict'

angular.module('group.service.module', [
  #dependencies 
  #$injector from angular core
  'generic.repository.module'
])

.factory('group.service', [
  '$injector'
  'generic.service'
  'group.repository'
  ($injector, service, groupR) ->
    service(groupR).extend(
      
      create: (players, tournament) ->  
        this.promises \
          this.default_repository.task().create(players, tournament.id)  
          
      get_scores: (group) ->
        this.default_repository.task().get_scores(group.id)            
)])