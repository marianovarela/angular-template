'use strict'

angular.module('weekBet.service.module', [
  #dependencies 
  #$injector from angular core
  'generic.repository.module'
])

.factory('weekBet.service', [
  '$injector'
  'generic.service'
  'weekBet.repository'
  ($injector, service, weekBetR) ->
    service(weekBetR).extend(
    
      get_by_player_and_week: (player, week) ->  this.promises \
        this.default_repository.task().get_by_player_and_week(player, week)  
      
      save_bet: (bets, weekId, player) ->  this.promises \
        this.default_repository.task().save_bet(bets, weekId, player) 
        
      get_my_points: (week, player) ->  this.promises \
        this.default_repository.task().get_my_points(week, player)   
         
)])