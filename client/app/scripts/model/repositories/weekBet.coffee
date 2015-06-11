'use strict';

angular.module('weekBet.repository.module', [
  #dependencies 
  #http from angular core
  'generic.repository.module'
])

.factory('weekBet.repository', [
  '$http'
  'generic.repository'
  'PATH'
  'attribute.loader'
  ($http, repository, PATH, attribute_loader) ->
    
    angular.extend(repository('weekBet'),
      
      transform: (raw) ->
        raw.load_bets = attribute_loader(raw, 'bets', 'bet')
        raw
        
      get_by_player_and_week : (player, week) -> @get_page_by_config
        search: 'findByPlayerAndWeek'
        params:
          player: player.id
          week:   week.id  
      
      save_bet : (bets, weekId, player) ->
        params =
          bets: bets
          weekId: weekId
          player: player.id
        config =
          method: 'POST'
          url: PATH.REST + 'weekBet/bet'
          data: $.param(params)
          headers:{'Content-Type': 'application/x-www-form-urlencoded'}
        this.promises $http(config)
        
      get_my_points : (week, player) ->
        params =
          player: player.id
          week: week.id
        config =
          method: 'POST'
          url: PATH.REST + 'weekBet/myBet'
          data: $.param(params)
          headers:{'Content-Type': 'application/x-www-form-urlencoded'}
        this.promises $http(config)  
        
)])
