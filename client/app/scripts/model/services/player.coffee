'use strict'

angular.module('player.service.module', [
  #dependencies 
  #$injector from angular core
  'generic.repository.module'
])

.factory('player.service', [
  '$injector'
  'generic.service'
  'player.repository'
  ($injector, service, playerR) ->
    service(playerR).extend(
    
      get_ranking: (limit) ->
        this.default_repository.task().get_ranking(limit)      
      
      get_by_tacId: (id) ->  this.promises \
        this.default_repository.task().get_by_tacId(id)   
        
      get_by_like_name: (name) ->  this.promises \
        this.default_repository.task().get_by_like_name(name) 
        
      get_by_name: (name) ->  this.promises \
        this.default_repository.task().get_by_name(name)         
      
      set_favorite: (player, team) ->  this.promises \
        this.default_repository.task().set_favorite(player, team)  
        
)])