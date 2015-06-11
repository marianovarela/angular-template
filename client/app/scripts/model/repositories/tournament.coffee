'use strict';

angular.module('tournament.repository.module', [
  #dependencies 
  #http from angular core
  'generic.repository.module'
])

.factory('tournament.repository', [
  '$http'
  'generic.repository'
  'PATH'
  'attribute.loader'
  ($http, repository, PATH, attribute_loader) ->
    
    angular.extend(repository('tournament'),
      
      transform: (raw) ->
        raw.load_currentWeek       = attribute_loader(raw, 'currentWeek', 'week')
        raw.load_weeks             = attribute_loader(raw, 'weeks',       'week')
        raw.load_teams             = attribute_loader(raw, 'teams',       'team')
        raw

      get_by_state: (state) -> @get_page_by_config
        search: 'findByState'
        params:
          state: state
          
      load_teams: (teams, tournament) -> 
        params =
          teams: teams
          tournament: tournament.id
        config =
          method: 'POST'
          url: PATH.REST + 'tournament/loadTeams'
          data: $.param(params)
          headers:{'Content-Type': 'application/x-www-form-urlencoded'}
        this.promises $http(config)   
        
      active: (tournament) -> 
        params =
          tournamentId: tournament.id
        config =
          method: 'POST'
          url: PATH.REST + 'tournament/active'
          data: $.param(params)
          headers:{'Content-Type': 'application/x-www-form-urlencoded'}
        this.promises $http(config)
        
      terminate: (tournament) -> 
        params =
          tournamentId: tournament.id
        config =
          method: 'POST'
          url: PATH.REST + 'tournament/ended'
          data: $.param(params)
          headers:{'Content-Type': 'application/x-www-form-urlencoded'}
        this.promises $http(config)       

)])
