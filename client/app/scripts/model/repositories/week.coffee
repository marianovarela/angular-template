'use strict';

angular.module('week.repository.module', [
  #dependencies 
  #http from angular core
  'generic.repository.module'
])

.factory('week.repository', [
  '$http'
  'generic.repository'
  'attribute.loader'  
  'PATH'
  ($http, repository, attribute_loader, PATH) ->
    
    angular.extend(repository('week'),
      
      transform: (raw) ->
        raw.load_matches    = attribute_loader(raw, 'matches'   , 'match')
        raw.load_tournament = attribute_loader(raw, 'tournament', 'tournament')
        raw
        
      load_results : (week, matches) ->
        params =
          matches: matches
          weekId: week.id
        config =
          method: 'POST'
          url: PATH.REST + 'week/results'
          data: $.param(params)
          headers:{'Content-Type': 'application/x-www-form-urlencoded'}
        this.promises $http(config) 

      load_week : (tournament, number, matches, start, end) ->
        params =
          number: number
          matches: matches
          tournamentId: tournament.id
          start: start
          end: end
        config =
          method: 'POST'
          url: PATH.REST + 'week/loadWeek'
          data: $.param(params)
          headers:{'Content-Type': 'application/x-www-form-urlencoded'}
        this.promises $http(config) 
        
)])
