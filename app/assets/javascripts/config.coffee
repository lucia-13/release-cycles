window.Config =
  viewport:
    width: 960
    height: 640
    center: null # calculated

  player:
    size: 8
    color: "#ffffff"
    initialAngle: 270
    controlSpeed: 1.4
    angularSpeed: 1
    angularSpeedIncrease: 0.15

  cycle:
    segments: 24
    outerRadius: 200
    innerRadius: 100
    centerRadius: null # calculated

  obstacles:
    interval: 1500
    effectDivisor: 2
    effectThreshold: 1

  actionValues:
    Pull: 20
    Push: 20
    Merge: 8
    Fork: 10

  gfx:
    trail:
      duration: 50
      reductionTo: 0.2
      interval: 5
      color: "#7f7f7f"

  flow:
    restartDelay: 1000

  music: [
    "sounds/music/04 - Bullcactus.mp3"
    "sounds/music/05 - Soft commando.mp3"
    "sounds/music/06 - Monster.mp3"
    "sounds/music/08  - Markus.mp3"
    "sounds/music/09 - Rofon.mp3"
    "sounds/music/10 - Datahell beta.mp3"
  ]


# calculated configurations
Config.cycle.centerRadius = (Config.cycle.outerRadius + Config.cycle.innerRadius) / 2 + 15
Config.viewport.center    = {x: Config.viewport.width / 2, y: Config.viewport.height / 2}