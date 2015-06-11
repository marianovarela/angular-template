'use strict';

angular.module('bet.repository.module', [
  #dependencies 
  #http from angular core
  'generic.repository.module'
])

.factory('bet.repository', [
  '$http'
  'generic.repository'
  'PATH'
  'attribute.loader'
  ($http, repository, PATH, attribute_loader) ->
    
    angular.extend(repository('bet'),
      
      transform: (raw) ->
        raw.load_match = attribute_loader(raw, 'match', 'match')        
        raw
        
      
        
)])
