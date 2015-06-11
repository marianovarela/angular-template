'use strict'

angular.module('score.service.module', [
  #dependencies 
  #$injector from angular core
  'generic.repository.module'
])

.factory('score.service', [
  '$injector'
  'generic.service'
  'score.repository'
  ($injector, service, scoreR) ->
    service(scoreR).extend(
    
      transform: (raw) ->
        raw     
      
      get_by_tournament: (id) ->  this.promises \
        this.default_repository.task().get_by_tournament(id)
        
      get_by_player_and_tournament: (player_id, tournament_id) ->  this.promises \
        this.default_repository.task().get_by_player_and_tournament(player_id, tournament_id)      
        
)])