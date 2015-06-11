'use strict';

angular.module('player.repository.module', [
  #dependencies 
  #http from angular core
  'generic.repository.module'
])

.factory('player.repository', [
  '$http'
  'generic.repository'
  'PATH'
  'attribute.loader'
  ($http, repository, PATH, attribute_loader) ->
    
    angular.extend(repository('player'),
      
      transform: (raw) ->
        raw.load_favorite = attribute_loader(raw, 'favorite','team')
        raw
        
      get_ranking: (limit) -> 
        params =
          limit: limit
        config =
          method: 'GET'
          url: PATH.REST + 'player/ranking'
          data: $.param(params)
          headers:{'Content-Type': 'application/x-www-form-urlencoded'}
        this.promises $http(config)   
      
      set_favorite: (player, team) -> 
        params =
          player: player.id
          team: team.id
        config =
          method: 'POST'
          url: PATH.REST + 'player/favorite'
          data: $.param(params)
          headers:{'Content-Type': 'application/x-www-form-urlencoded'}
        this.promises $http(config)
      
      get_by_tacId: (id) -> @get_page_by_config
        search: 'findByTacId'
        params:
          tacId: id  
          
      get_by_like_name: (name) -> @get_page_by_config
        search: 'findByLikeName'
        params:
          name: name  
          
      get_by_name: (name) -> @get_page_by_config
        search: 'findByName'
        params:
          name: name         
)])
