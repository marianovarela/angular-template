angular.module('keyboard.control.module', [])

.service('keyboard.control', [
  '$rootScope'
  ($rootScope) ->
    
    listeners = []
    listeners_stack = []
    
    keycodes = [
        key: 'left'
        code: 37
      ,
        key: 'up'
        code: 38
      ,
        key: 'right'
        code: 39
      ,
        key: 'down'
        code: 40
      ,
        key: 'enter'
        code: 13
      ,
        key: 'info'
        code: 457
      ,
        key: 'info'
        code: 73 #keyboard I
      ,
        key: 'red'
        code: 403
      ,
        key: 'red'
        code: 82 #keyboard R
      ,
        key: 'green'
        code: 404
      ,
        key: 'green'
        code: 71 #keyboard G
      ,
        key: 'yellow'
        code: 405
      ,
        key: 'yellow'
        code: 89 #keyboard Y
      ,
        key: 'blue'
        code: 406
      ,
        key: 'blue'
        code: 66 #keyboard B
      ,
        key: 'play'
        code: 415
      ,
        key: 'play'
        code: 32 #keyboard space
      ,
        key: 'pause'
        code: 19
      ,
        key: 'pause'
        code: 80 #keyboard P
      ,
        key: 'rewind'
        code: 412
      ,
        key: 'rewind'
        code: 74 #keyboard j
      ,
        key: 'fast_fwd'
        code: 417
      ,
        key: 'fast_fwd'
        code: 75 #keyboard k
      ]
      
    get_keycode = (code)->
      for keycode in keycodes
        if keycode.code is code
          return keycode
       
    class Control
      
      @subscribe = (listener)->
        listeners.push listener
        -> unsubscribe listener
      
      @unsubscribe = (listener)->
        _.remove listeners, listener
        
      @create_level = ()->
        listeners_stack.push listeners
        listeners = []
        
      @previous_level = ()->
        if listeners_stack.length > 0
          listeners = listeners_stack.pop()
        else
          console.error "trying to pop unique listener array from listeners_stack"
      
      @initialize = ->
        document.onkeydown = (event)->
          if keycode = get_keycode event.keyCode
            for listener in listeners
              listener.handle keycode.key
            event.preventDefault()
            return false
          else
            console.log 'unregistered key' + event.keyCode
      
      
])