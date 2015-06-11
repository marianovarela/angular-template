'use strict'

console.log 'checking system existence'

if typeof window.system is 'undefined'
  
  console.log 'initialize system'
  
  #return_error_on_getInfo = new EvalError('mensaje del error')
  #return_error_on_getInfo = {name:'TypeError', message:'Incorrect PackageId', description:'El atributo packageId proporcionado no se corresponde con ninguna aplicacion disponible.'}
  return_error_on_getInfo = false
  delay = 1000
  data = 
    id : '1234'
    hash : 'readonly'
  
  window.system = 
    getInfo : (callback)->
      callback return_error_on_getInfo, data
            
      
  