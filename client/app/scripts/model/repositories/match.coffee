'use strict';

angular.module('match.repository.module', [
  #dependencies 
  #http from angular core
  'generic.repository.module'
])

.factory('match.repository', [
  '$http'
  'generic.repository'
  'PATH'
  'attribute.loader'
  ($http, repository, PATH, attribute_loader) ->
    
    angular.extend(repository('match'),
      
      transform: (raw) ->
        raw.load_local       = attribute_loader(raw, 'local', 'team')
        raw.load_visitor     = attribute_loader(raw, 'visitor', 'team')
        raw
        
)])
