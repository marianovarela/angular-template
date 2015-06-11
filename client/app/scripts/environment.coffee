'use strict'

angular.module('app')

 #invoke only in tienda module
.factory('environment',[
  'environment-vars'
  (ENV_VARS)->
    #API:        ENV_VARS.API.LOCAL
    API:        ENV_VARS.API.MINPLAN.TESTING
])

#invoke only in this module
.constant('environment-vars', 
  API:      
    #LOCAL:     'http://172.32.200.109:8083'  
    LOCAL:        'http://localhost:8083'
    MINPLAN:
      PRODUCTION: 'http://tiendatac.minplan.gob.ar' # TODO cambiar por la url correspondiente
      TESTING:    'http://190.210.150.121'          #
      
)

