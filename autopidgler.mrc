on 1:connect: {
  if ($server == tmi.twitch.tv) {
    /timerpidgler 0 1200 pidgler
  }
}

alias pidgler {
  var %randtime = $rand(1,300)

  var %options = 3,3,3,3,3,3,3,3,3,3,3,3,3,3,4,4,4,4,4,5,5,5,6,6,10
  var %numoptions = $numtok(%options, 44)
  var %legs = $gettok(%options,$rand(1,%numoptions),44)

  var %pidgler
  var %j = 1
  while (%j <= %legs) {
    var %legConfig = $rand(1,3)
    if (%legConfig = 1) {
      %pidgler = %pidgler $+ $chr(32) $+ $chr(44) $+ $chr(40)
    }
    else if (%legConfig = 2) {
      %pidgler = %pidgler $+ $chr(44) $+ $chr(40)
    }
    else if (%legConfig = 3) {
      %pidgler = %pidgler $+ $chr(44) $+ $chr(32) $+ $chr(40)

    }
    inc %j
  }

  timer1 1 %randtime /describe #pidgezero_one $chr(40) $+ %pidgler $+ $chr(32) $+ ͡° ͜ʖ ͡°)¯*

}
