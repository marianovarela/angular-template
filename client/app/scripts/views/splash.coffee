'use strict'

angular.module('view.splash.controller.module', [])

.controller 'view.splash.controller',([
  '$scope'
  '$http'
  ($scope, $http) ->
    
    get1 = (url) ->
      xmlhttp = undefined
      if window.XMLHttpRequest
        # code for IE7+, Firefox, Chrome, Opera, Safari
        xmlhttp = new XMLHttpRequest
      else
        # code for IE6, IE5
        xmlhttp = new ActiveXObject('Microsoft.XMLHTTP')
    
      xmlhttp.onreadystatechange = ->
        if xmlhttp.readyState == 4
          console.log xmlhttp
          if xmlhttp.status == 200
            console.log 'success'
            console.log get_tokens xmlhttp.response
          else
            console.log 'success'
            console.log get_tokens xmlhttp.response
        return
    
      xmlhttp.open 'POST', url, true
      xmlhttp.setRequestHeader 'Authorization', 'OAuth oauth_consumer_key="wnjvP8jnpKWA39oYRMlNVCJRX", oauth_nonce="5e4091e63f6f2b572a3044d7810614a0", oauth_signature="GKuABztaxQfGX6iOpc%2BkPJoOJGY%3D", oauth_signature_method="HMAC-SHA1", oauth_timestamp="1435694085", oauth_token="3350746966-Cvk4nnVvcS2D0Vl6oX8qWKW3tIvwZN8jakTT48Q", oauth_version="1.0"'
      xmlhttp.send()
      return

    init = () ->
      token = get1('http://127.0.0.1:7777/oauth/request_token')
      
    get_tokens = (tokens) ->
      url = tokens
      values = url.split('&')
      object = {}
      for value in values
        raw_values = value.split('=')
        object[raw_values[0]] = raw_values[1]
      return object
        
    init()    
        
])