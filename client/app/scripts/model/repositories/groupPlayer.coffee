'use strict';

angular.module('groupPlayer.repository.module', [
  #dependencies 
  #http from angular core
  'generic.repository.module'
])

.factory('groupPlayer.repository', [
  '$http'
  'generic.repository'
  'PATH'
  'attribute.loader'
  ($http, repository, PATH, attribute_loader) ->
    
    angular.extend(repository('groupPlayer'),
      
      transform: (raw) ->
        raw.load_group  = attribute_loader(raw, 'group' ,'group')
        raw.load_player = attribute_loader(raw, 'player','player')
        raw
        
      get_by_player_and_tournament: (player_id, tournament_id) -> @get_page_by_config
        search: 'findByPlayerAndTournament'
        params:
          player: player_id
          tournament: tournament_id
        
)])
