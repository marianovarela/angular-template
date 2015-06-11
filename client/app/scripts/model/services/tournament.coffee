'use strict'

angular.module('tournament.service.module', [
  #dependencies 
  #$injector from angular core
  'generic.repository.module'
])

.factory('tournament.service', [
  '$injector'
  'generic.service'
  'tournament.repository'
  ($injector, service, tournamentR) ->
    service(tournamentR).extend(
    
      get_by_state: (state) ->  this.promises \
        this.default_repository.task().get_by_state(state)  
        
      load_teams: (teams, tournament) ->  this.promises \
        this.default_repository.task().load_teams(teams, tournament)   
        
      active: (tournament) ->  this.promises \
        this.default_repository.task().active(tournament)   
        
      terminate: (tournament) ->  this.promises \
        this.default_repository.task().terminate(tournament)       
)])