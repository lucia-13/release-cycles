Crafty.c "MoveInCircle",
  _radius: Config.cycleCenterRadius
  _initialAngle: Config.player.initialAngle
  _speed: null
  _sideSpeed: null
  _angle: 0
  _movement: 0

  _keys:
    RIGHT_ARROW: -1
    LEFT_ARROW: +1
    A: +1
    D: -1
    H: +1
    L: -1

  init: ->
    @requires('Delay')
    @reset()
    @_setKeys()
    @origin("center")
    @disableControl()
    @enableControl()
    @color(Config.gfx.player.color)
    @attr(h:Config.player.size, w:Config.player.size)


  reset: ->
    @_angle = @_initialAngle
    @_speed = Config.player.speed.angular.initial
    @_sideSpeed = Config.player.speed.sides.initial
    @_trailInterval = Config.gfx.trail.interval.initial
    @_radius = Config.cycle.centerRadius + Config.player.radiusModification
    @attr(
      x: 0
      y: 0
    )
    @

  angle: ->
    @_angle % 360

  _keydown: (e) ->
    if @_keys[e.key]
      @_movement = @_keys[e.key] * @_sideSpeed
      @trigger "NewDirection", @_movement

  _keyup: (e) ->
    @_movement = 0

  hide: ->
    @visible = false
    @draw()
    @
  show: ->
    @visible = true
    @draw()
    @

  disableControl: ->
    @hide().unbind("KeyDown", @_keydown).unbind("KeyDown", @_keydown).unbind "EnterFrame", @_enterframe
    @

  enableControl: ->
    @show().bind("KeyDown", @_keydown).bind("KeyUp", @_keyup).bind "EnterFrame", @_enterframe
    @

  _enterframe: ->
    return if @disableControls
    @_angle += @_speed
    if @_angle > 360 + @_initialAngle
      @_angle -= 360
      @upgrade()
      Crafty.trigger('LevelUp')
    @_radius += @_movement
    @rotation = @_angle - @_initialAngle
    coords = Utils.polarCnv(@_radius, @_angle)
    old = {x:@x, y:@y}
    @x = coords.x
    @y = coords.y
    @trigger("Moved",
      x: old.x
      y: old.y
    )
    @_generateTrail()

  _setKeys: ->
    newKeys = {}
    _.each(@_keys, (v,k) ->
      newKeys[Crafty.keys[k]] = v
    )
    @_keys = newKeys

  _generateTrail: ->
    return unless Crafty.frame() % @_trailInterval == 0
    Crafty.e("Trail").attr(rotation: @rotation, x: @_x, y: @_y).Trail()

  upgrade: ->
    @_speed += Config.player.speed.angular.increase
    @_speed = Math.min(@_speed, Config.player.speed.angular.maximum)

    @_sideSpeed += Config.player.speed.sides.increase
    @_sideSpeed = Math.min(@_speed, Config.player.speed.sides.maximum)

    @_trailInterval -= Config.gfx.trail.interval.reduceBy
    @_trailInterval = Math.max(@_trailInterval, Config.gfx.trail.interval.minimum)
    @