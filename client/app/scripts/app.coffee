'use strict'

angular.module('app')

.run([
  '$rootScope'
  'background.service'
  ($rootScope, backgroundS) ->
    
    backgroundS.initialize()
    
])

#invoke only in this file
.constant('configuration', 

  #HOST:     'http://172.32.200.109:8083'
  HOST:     'http://localhost:8083'
  REST:     '/prode-api/v1/'
  
  LOGIN:    'security/sessionManager'
  
  SESSION:
      SLOT: 'managers' #que es esto?
)

.factory('PATH',[
  'configuration'
  'environment'
  (CFG, ENV) ->
    I18N:    'app/i18n'
    ASSETS : '/app/assets'
    REST:    ENV.API + CFG.REST
    
    LOGIN:    CFG.HOST + CFG.REST + CFG.LOGIN
])

.config([
  '$httpProvider'
  ($httpProvider) ->
    
    ###### hardcoded login #######
    user =     'readonly'
    password = 'readonly'
    $httpProvider.defaults.headers.common.Authorization = 'Basic ' + btoa( user + ':' + password)
    ##############################

])
