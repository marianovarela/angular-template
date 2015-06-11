'use strict'

angular.module('control.component.module')

.factory('leaf.component', [
  '$injector'
  ($injector)->
    
    set_focus_behaviour = (navigable, element)->
      if element[0].type is 'text'
        navigable.on_active -> element[0].focus()
        navigable.on_not_active -> element[0].blur()
        
    process_keyboard_attr = (navigable, attrs, element)->
      if attrs.openKeyboard
        navigable.click = ->
          keyboardS = $injector.get('keyboard.modal.service')
          container = 
            text: element.val()
          modal_instance = keyboardS.show_in_modal container
          modal_instance.result.then -> 
            element.val container.text
            element.trigger('input')
          modal_instance.result.finally -> 
            navigable.set_active()
          
    run_calbacks = (callbacks, self)->
      for callback in callbacks
        callback self
    
    (element, attrs, clazz)->
      navigable =
        identifier: attrs.navigableLeafId
        handle: (key)->
          if key is 'enter'
            @click()
            return true
          false
        on_active_callbacks: []
        on_not_active_callbacks: []
        on_active: (callback)-> @on_active_callbacks.push callback
        on_not_active: (callback)-> @on_not_active_callbacks.push callback
        set_active: -> 
          run_calbacks @on_active_callbacks, this
          @active = true 
        set_not_active: -> 
          run_calbacks @on_not_active_callbacks, this
          @active = false
        set_navigable_link: (navigable_link)->
          @navigable_link = navigable_link
          set_focus_behaviour navigable, navigable_link
          @click = -> navigable_link.click()
        click: -> 
          element.click()
          true
        
      
      if clazz
        navigable.on_active -> element.addClass clazz
        navigable.on_not_active -> element.removeClass clazz
          
      set_focus_behaviour(navigable, element)
      process_keyboard_attr(navigable, attrs, element)
      
      navigable
          
])

.constant('navigable.events',
  NAVIGABLE_PROCESSED: 'navigable_processed'
)

.directive('navigableLeafModel', [
  '$parse'
  'leaf.component'
  'navigable.events'
  ($parse, leaf, EVENTS) ->
    link: (scope, element, attrs) ->
      index = parseInt($parse('$index') scope)
      model = $parse(attrs.navigableLeafModel) scope
      component = leaf element, attrs
      model.navigable = component
      scope.add_navigable_component component, index
      scope.set_navigable_link = (navigable_link)-> component.set_navigable_link(navigable_link)
      scope.navigable_processed = true
      scope.$broadcast EVENTS.NAVIGABLE_PROCESSED
      scope.$emit EVENTS.NAVIGABLE_PROCESSED, model
      if attrs.removeOnDestroy
        scope.$on '$destroy', -> scope.remove_navigable_component component
      
        
])

.directive('navigableLeaf', [
  '$parse'
  'leaf.component'
  'navigable.events'
  ($parse, leaf, EVENTS) ->
    link: (scope, element, attrs) ->
      component = leaf element, attrs, attrs.navigableLeafClass
      index = parseInt(attrs.navigableLeaf)
      scope.add_navigable_component component, index
      if attrs.navigableLeafActive
        component.parent.set_current_component component
        component.parent.set_active(true, true)
])

.directive('navigableLink', [
  '$parse'
  'navigable.events'
  ($parse, EVENTS) ->
    
    link: (scope, element, attrs) ->
      if scope.navigable_processed
        scope.set_navigable_link element
      else
        scope.$on EVENTS.NAVIGABLE_PROCESSED, -> scope.set_navigable_link element
      
      
])
