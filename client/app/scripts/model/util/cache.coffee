'use strict';

angular.module('cache.service.module', [
  #dependencies 
])

.factory('cache.service', [
  () ->
    
    cache: 
      bet            : {}
      match          : {}
      player         : {}
      team           : {}
      tournament     : {}
      score          : {}
      week           : {}
      weekBet        : {}
      group          : {}
      groupPlayer    : {}
    
    get: (type, id) ->
      this.cache[type][id]

    set: (type, data, key) ->
      #if receives @id then @data is a promise
      #else data is a @type instance
      key = key || data.id
      type_store = this.cache[type]
      if this.cache[type]
        type_store[key] = data
      else 
        console.log('trying to store incorrect data in cache')
        console.log('ther is not entity with type ' + type)

])