angular.module('control.component.module', [])

.factory('control.root.component',[
  'control.extensible.component'
  'sound.service'
  (extensible, sound)->(identifier)->
    
    root_component = extensible.create_basic(identifier).initialize()
    
    root_component.handle_inner = (key)->
      not @active and
      not _.isEmpty(@components) and
      @set_child_active() or
      sound.error()
        
    root_component.root = ()->
      this
        
    root_component.handle = (key)->
      @last_action = key
      @handle_by_child(key) or
      @handle_inner(key)
              
    root_component.set_child_active = ()-> 
      child_index = 0
      while not @active and child_index < @components.length
        @active = @set_current_component @components[child_index]
        child_index += 1
      if @active then @current_component.apply()
      @active
      
    root_component.set_active_down_to_up = (child_component, changed_child)->
      @active = true
      @set_current_component child_component
      if changed_child
        @apply()
    
    root_component.set_not_active = () ->
      @active = false
      if @current_component then @current_component.set_not_active()
      
    root_component.bind_to = (scope) ->
      self = this
      scope.add_navigable_component = (component, index)->
        self.add(component, index)
      this
      
    root_component
  
])

.service('root.component.service', [
  '$rootScope'
  'control.root.component'
  ($rootScope, root_component) ->
    
    root_service = root_component('root')
    
    $rootScope.$on '$routeChangeStart', -> root_service.set_not_active()
    
    root_service
    
])