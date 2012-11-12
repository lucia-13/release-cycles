Crafty.c("Segment",

  innerRadius: Config.cycle.innerRadius
  outerRadius: Config.cycle.outerRadius
  _inner: null
  _outer: null

  Segment: () ->
    @_inner = Crafty.e("Obstacle").radius(@innerRadius).pivot(@pivot).angle(@angle).Obstacle()
    @_outer = Crafty.e("Obstacle").radius(@outerRadius).pivot(@pivot).angle(@angle).Obstacle()
    @

  pivot: (pivot)->
    @attr('pivot', pivot)
    @

  angle: (angle)->
    @attr('angle', angle)
    @

  preceeding: (segment) ->
    return @ unless segment
    @prev = segment
    segment.next = @
    @

  upgrade: ->
    @_inner.upgrade()
    @_outer.upgrade()

  reset: ->
    @_inner.reset()
    @_outer.reset()

  perform: (action, value = null) ->
    value = Config.actionValues[action] unless value
    return if value < Config.obstacles.effectThreshold

    switch action
      when "Pull"
        @_inner.shiftRadius(-value)
        @_outer.shiftRadius(-value)
      when "Push"
        @_inner.shiftRadius(+value)
        @_outer.shiftRadius(+value)
      when "Fork"
        @_inner.shiftRadius(-value)
        @_outer.shiftRadius(+value)
      when "Merge"
        @_inner.shiftRadius(+value)
        @_outer.shiftRadius(-value)

    @prev.perform(action, value / Config.obstacles.effectDivisor)
    @next.perform(action, value / Config.obstacles.effectDivisor)
)
