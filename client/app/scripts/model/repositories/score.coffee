'use strict';

angular.module('score.repository.module', [
  #dependencies 
  #http from angular core
  'generic.repository.module'
])

.factory('score.repository', [
  '$http'
  'generic.repository'
  'PATH'
  'attribute.loader'
  ($http, repository, PATH, attribute_loader) ->
    
    angular.extend(repository('score'),
      
      transform: (raw) ->
        raw.load_player       = attribute_loader(raw, 'player',       'player'  )
        raw.load_tournament       = attribute_loader(raw, 'tournament',       'tournament'  )
        raw
      
      get_by_tournament: (id) -> @get_page_by_config
        search: 'findByTournament'
        params:
          id: id 
      
      get_by_player_and_tournament: (player_id, tournament_id) -> @get_page_by_config
        search: 'findByPlayerAndTournament'
        params:
          player: player_id
          tournament: tournament_id
             
)])
