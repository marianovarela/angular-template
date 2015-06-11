'use strict';

angular.module('team.repository.module', [
  #dependencies 
  #http from angular core
  'generic.repository.module'
])

.factory('team.repository', [
  '$http'
  'generic.repository'
  'PATH'
  ($http, repository, PATH) ->
    
    angular.extend(repository('team'),
      
      transform: (raw) ->
        raw
      
      get_by_tournament: (id) -> @get_page_by_config
        search: 'findByTournament'
        params:
          id: id      
)])
