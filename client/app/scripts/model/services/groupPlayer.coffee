'use strict'

angular.module('groupPlayer.service.module', [
  #dependencies 
  #$injector from angular core
  'generic.repository.module'
])

.factory('groupPlayer.service', [
  '$injector'
  'generic.service'
  'groupPlayer.repository'
  ($injector, service, groupPlayerR) ->
    service(groupPlayerR).extend(
    
      get_by_player_and_tournament: (player, tournament_id) ->  this.promises \
        this.default_repository.task().get_by_player_and_tournament(player.id, tournament_id)    
)])