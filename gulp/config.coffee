argv = require('yargs').argv

main = argv.main || '/home/assassin/repositories/ali-express-mining'
temp = "#{main}/temp"
out = "#{main}/out.txt"
waitScreenShot = "#{temp}/wait-screen-shot.png"

exports.paths =
  main: main
  temp: temp
  out: out
  waitScreenShot: waitScreenShot

exports.deviceAdress = argv.adress || '192.168.11.12:5555'

###

Разрешение на эмуляторе 720х1280, все координаты берутся исходя из этого

###

exports.device =
  screen:
    width: 720
    height: 1280

exports.coordinates =
  bonuxPage:
    x: 255
    y: 610
  coin:
    x: 361
    y: 254
  unlockScreen:
    1:
      x: 400
      y: 1100
    2:
      x: 600
      y: 900
    3:
      x: 600
      y: 1000
    4:
      x: 600
      y: 900
    5:
      x: 600
      y: 1100


exports.adb =
  shell:
    input:
      keyevents:
        home: 3
        unlockScreen: 26

exports.cut =
  code:
    options:
      width: 200
      height: 50
      top: 75
      left: 300

exports.states =
  main:
    coordinates:
      start:
        x: 220
        y: 540
      end:
        x: 360
        y: 750
    hash: '4a77f54b'#'37e4c406'
  bonus:
    coordinates:
      start:
        x: 16
        y: 185
      end:
        x: 40
        y: 220
    hash: '0429ff38'
  noCount:
    coordinates:
      start:
        x: 50
        y: 190
      end:
        x: 110
        y: 220
    hash: '6262ldca'