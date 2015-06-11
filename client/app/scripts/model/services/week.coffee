'use strict'

angular.module('week.service.module', [
  #dependencies 
  #$injector from angular core
  'generic.repository.module'
])

.factory('week.service', [
  '$injector'
  'generic.service'
  'week.repository'
  ($injector, service, weekR) ->
    service(weekR).extend(
    
      transform: (raw) ->
        raw  
      
      format_matches: (matches) ->
        games = []
        for match in matches
          game = 
            id: match.id
            localResult: match.resultLocal
            visitorResult: match.resultVisitor
          games.push(JSON.stringify(game))  
        games
        if games.length is 1
          games.push ""
        games  
        
      format_matches_for_week: (matches) ->
        games = []
        for match in matches
          game = 
            local: match.local.id
            visitor: match.visitor.id
          games.push(JSON.stringify(game))  
        games
        if games.length is 1
          games.push ""
        games    
        
      load_results: (week, matches) ->  
        matches = this.format_matches matches
        this.promises \
          this.default_repository.task().load_results(week, matches) 
      
      fix_javascript_date : (birthday) ->
        date = new Date(birthday)
        day = date.getDate()
        date = new Date(date.setDate(day + 1))
        date
      
      load_week: (tournament, number, matches, start, end) ->  
        start = this.fix_javascript_date start
        end = this.fix_javascript_date end
        matches = this.format_matches_for_week matches
        this.promises \
          this.default_repository.task().load_week(tournament, number, matches, start, end)          
        
)])