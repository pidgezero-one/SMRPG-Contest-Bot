on *:TEXT:!guess*:#:{
  if ($nick == pidgezero_one) {
    if (%gameActive == on) {
      endGame $$2
      if (%game == smrpg && %gameCounter == 4) {
        reset
      }
    }
    else if (%gameActive == off) {
      startGame
    }
  }
}
on *:TEXT:!reset:#:{
  if ($nick == pidgezero_one) {
    reset
  }
}
on *:TEXT:!skip:#:{
  if ($nick == pidgezero_one) {
    skipGame
  }
}
on *:TEXT:!points*:#:{
  if (% [ $+ [ $nick ] ] == $null) {
    var %pts = 0
  }
  else {
    var %pts = %leaderboard. [ $+ [ $nick ] ]
  }
  msg $active $nick has %pts completely useless points.
}
on *:TEXT:!leaderboard*:#:{
  var %timestamp = $calc($regml(1) * 6000 + $regml(3) * 100 + $regml(5))
  var %i = 1, %n = $var(leaderboard $+ *,0), %var
  var %winner
  var %winningPoints
  var %2ndwinner
  var %2ndwinningPoints
  var %3rdwinner
  var %3rdwinningPoints

  while (%i <= %n) {
    %var = $gettok($var(leaderboard $+ *,%i),2-,46)
    if (%winningPoints == $null) { ;first by default
      set %winningPoints %leaderboard. [ $+ [ %var ] ]
      set %winner @ $+ %var
    }
    elseif ( %leaderboard. [ $+ [ %var ] ] > %winningPoints) { ; in 1st
      set %3rdwinner %2ndwinner
      set %3rdwinningPoints %2ndwinningPoints
      set %2ndwinner %winner
      set %2ndwinningPoints %winningPoints
      set %winner @ $+ %var
      set %winningPoints %leaderboard. [ $+ [ %var ] ] 
    }
    elseif ( %leaderboard. [ $+ [ %var ] ] == %2ndwinningPoints) { ;tie for 2nd
      set %2ndwinner %2ndwinner $+ $chr(44) $+ $chr(32) $+ @ $+ %var
    }
    elseif ( %leaderboard. [ $+ [ %var ] ] < %winningPoints && (%3rdwinningPoints == $null || (%3rdwinningPoints != $null && %leaderboard. [ $+ [ %var ] > %3rdwinningPoints))) { ; in 2nd
      set %3rdwinner %2ndwinner
      set %3rdwinningPoints %2ndwinningPoints
      set %2ndwinner @ $+ %var 
      set %2ndwinningPoints %leaderboard. [ $+ [ %var ] ]
    }
    elseif ( %leaderboard. [ $+ [ %var ] ] == %3rdwinningPoints) { ;tie for 3rd
      set %3rdwinner %3rdwinner $+ $chr(44) $+ $chr(32) $+ @ $+ %var
    }
    elseif (( %leaderboard. [ $+ [ %var ] ] < %2ndwinningPoints && %leaderboard. [ $+ [ %var ] ] > %3rdwinningPoints) || %3rdwinningPoints == $null) { ; in 3rd
      set %3rdwinner @ $+ %var 
      set %3rdwinningPoints %leaderboard. [ $+ [ %var ] ]
    }
    inc %i
  }
  msg $active 1st: %winner ( $+ %winningPoints $+ pts) --- 2nd: %2ndwinner ( $+ %2ndwinningPoints $+ pts) --- %3rdwinner ( $+ %3rdwinningPoints $+ pts)
}




alias reset {
  set %gameActive off
  set %accept off
  set %gameCounter 0
  timerAccept off
  unset %bomb*
  unset %minecart*
  unset %cys*
  unset %sandstorm*

}
