'use strict';

angular.module('group.repository.module', [
  #dependencies 
  #http from angular core
  'generic.repository.module'
])

.factory('group.repository', [
  '$http'
  'generic.repository'
  'PATH'
  'attribute.loader'
  ($http, repository, PATH, attribute_loader) ->
    
    angular.extend(repository('group'),
      
      transform: (raw) ->
        raw.load_groupPlayers = attribute_loader(raw, 'groupPlayers','groupPlayer')
        raw.load_tournament   = attribute_loader(raw, 'tournament','tournament')
        raw
        
      create: (players, tournamentId) -> 
        params =
          tournament: tournamentId
          playerIds: players
        config =
          method: 'POST'
          url: PATH.REST + 'group/create'
          data: $.param(params)
          headers:{'Content-Type': 'application/x-www-form-urlencoded'}
        this.promises $http(config)   
        
      get_scores: (group_id) -> 
        params =
          groupId: group_id
        config =
          method: 'POST'
          url: PATH.REST + 'group/scores'
          data: $.param(params)
          headers:{'Content-Type': 'application/x-www-form-urlencoded'}
        this.promises $http(config)  
        
)])
