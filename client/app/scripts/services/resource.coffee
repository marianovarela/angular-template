'use strict'

angular.module('resource.service.module', [
  #dependencies 
  
])

.factory('resource.service', [
  'PATH'
  '$http'
  (PATH, $http) ->
    
    get : (location) ->
      config = 
        type: 'GET'
        url: PATH.REST + '/' + location  + '.json'
        headers:{
          'apikey': '3b3c2d576b647d6579726060606022512c7f646d6f607e37'
          'Content-Type': 'application/x-www-form-urlencoded'
        }
      $http(config)  
    
    get_with_params : (location, query) ->
      config = 
        type: 'GET'
        url: PATH.REST + '/' + location + '/' + query + '.json'
        headers:{
          'apikey': '3b3c2d576b647d6579726060606022512c7f646d6f607e37'
          'Content-Type': 'application/x-www-form-urlencoded'
        }
      $http(config)  
    
    search : (query) ->
      data = 
        call: 'search'
        query: query
        response: 'json'
      $.ajax
        data: data
        type: 'POST'
        url: PATH.REST
        headers:{
          'apikey': '3b3c2d576b647d6579726060606022512c7f646d6f607e37'
          'Content-Type': 'application/x-www-form-urlencoded'
        }
        
    get_categories : () ->
      @get('categories')
      
    get_index : () ->
      @get('index')  
    
    get_category : (id) ->
      @get('list/' + id)  
    
    get_item : (id) ->
      @get('item/' + id)
      
    get_search : (query) ->
      @search(query)
      
])
