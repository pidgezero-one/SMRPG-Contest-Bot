alias startGame {
  set %gameActive on
  inc %gameCounter
  set %accept on
  /timerAccept 1 60 closeSubmissions
  if (%game == smrpg) {
    if (%gameCounter == 1) {
      startCroco
    }
    else if (%gameCounter == 2) {
      startMinecart
    }
    else if (%gameCounter == 3) {
      startCys
    }
    else if (%gameCounter == 4) {
      startCake
    }
  }
}
alias closeSubmissions {
  set %accept off
  msg $active Submissions closed! 
}

alias skipGame {
  inc %gameCounter
}

alias endGame {
  if (%gameCounter == 1) {
    crocoWinners $$1
  }
  elseif (%gameCounter == 2) {
    minecartWinners $$1
  }
  elseif (%gameCounter == 3) {
    cysWinners $$1
  }
  elseif (%gameCounter == 4) {
    sandstormWinners $$1
  }
  set %gameActive off
}

alias minecartWinners {
  if ($regex($$1,(\d)(\.|:)(\d\d)(\.|:)(\d\d))) {
    var %timestamp = $calc($regml(1) * 6000 + $regml(3) * 100 + $regml(5))
    var %i = 1, %n = $var(minecart $+ *,0), %var
    if (%n <= 1) {
      msg $active Since there was only 1 guess, no points will be awarded.
    }
    elseif (%n == 2) {
      var %winner
      var %winningTime
      var %winners
      while (%i <= %n) {
        %var = $gettok($var(minecart $+ *,%i),2-,46)
        if ( $abs($calc(%minecart. [ $+ [ %var ] ] - %timestamp )) < %winningTime || %winningTime == $null) {
          set %winningTime $abs($calc(%minecart. [ $+ [ %var ] ] - %timestamp ))
          set %winner @ $+ %var
          set %winners %var
        }
        elseif ( $abs($calc(%minecart. [ $+ [ %var ] ] - %timestamp )) == %winningTime) {
          set %winner %winner $+ $chr(44) $+ $chr(32) $+ @ $+ %var
          set %winners %winners $+ $chr(44) $+ %var
        }
        inc %i
      }
      if ($numtok(%winners,44) == 1) {
        inc %leaderboard. [ $+ [ %winners ] ] 1
      }
      elseif ($numtok(%winners,44) > 1) {
        var %j = 1
        while (%j <= $numtok(%winners,44)) {
          inc %leaderboard. [ $+ [ $gettok(%winners,%j,44) ] ] 1
          inc %j
        }
      }
      msg $active 1 point to %winner for guessing the closest time!
    }
    elseif (%n > 2) {
      var %winner
      var %winningTime
      var %2ndwinner
      var %2ndwinningTime
      var %winners
      var %2ndwinners
      while (%i <= %n) {
        %var = $gettok($var(minecart $+ *,%i),2-,46)
        if (%winningTime == $null) {
          set %winningTime $abs($calc(%minecart. [ $+ [ %var ] ] - %timestamp ))
          set %winner @ $+ %var
          set %winners %var
        }
        elseif ( $abs($calc(%minecart. [ $+ [ %var ] ] - %timestamp )) == %winningTime) {
          set %winner %winner $+ $chr(44) $+ $chr(32) $+ @ $+ %var
          set %winners %winners $+ $chr(44) $+ %var
        }
        elseif ( $abs($calc(%minecart. [ $+ [ %var ] ] - %timestamp )) < %winningTime) {
          set %2ndwinner %winner
          set %2ndwinners %winners
          set %2ndwinningtime %winningTime
          set %winningTime $abs($calc(%minecart. [ $+ [ %var ] ] - %timestamp ))
          set %winner @ $+ %var
          set %winners %winners $+ $chr(44) $+ %var
        }
        elseif ( $abs($calc(%minecart. [ $+ [ %var ] ] - %timestamp )) > %winningTime && ($abs($calc(%minecart. [ $+ [ %var ] ] - %timestamp )) < %2ndwinningTime || %2ndwinningTime == $null)) {
          set %2ndwinningTime $abs($calc(%minecart. [ $+ [ %var ] ] - %timestamp ))
          set %2ndwinner @ $+ %var
          set %2ndwinners %var
        }
        elseif ( $abs($calc(%minecart. [ $+ [ %var ] ] - %timestamp )) > %winningTime && $abs($calc(%minecart. [ $+ [ %var ] ] - %timestamp )) == %2ndwinningTime) {
          set %2ndwinner %2ndwinner $+ $chr(44) $+ $chr(32) $+ @ $+ %var
          set %2ndwinners %2ndwinners $+ $chr(44) $+ %var
        }
        inc %i
      }
      if ($numtok(%winners,44) == 1) {
        inc %leaderboard. [ $+ [ %winners ] ] 5
      }
      elseif ($numtok(%winners,44) > 1) {
        var %j = 1
        while (%j <= $numtok(%winners,44)) {
          inc %leaderboard. [ $+ [ $gettok(%winners,%j,44) ] ] 5
          inc %j
        }
      }
      if ($numtok(%2ndwinners,44) == 1) {
        inc %leaderboard. [ $+ [ %2ndwinners ] ] 1
      }
      elseif ($numtok(%2ndwinners,44) > 1) {
        var %j = 1
        while (%j <= $numtok(%2ndwinners,44)) {
          inc %leaderboard. [ $+ [ $gettok(%2ndwinners,%j,44) ] ] 1
          inc %j
        }
      }
      msg $active 5 points to %winner for guessing the closest time!
      msg $active 1 point to %2ndwinner for guessing the second closest time.
    }
  }
  else {
    msg $active lol i messed up sry no contest
  }
  unset %minecart*
}

alias crocoWinners {
  var %1point, %2point
  var %i = 1, %n = $var(bomb $+ *,0), %var
  while (%i <= %n) {
    %var = $gettok($var(bomb $+ *,%i),2-,46)
    if (%bomb. [ $+ [ %var ] ] == $$1) {
      inc %leaderboard. [ $+ [ %var ] ] 2
      if (%2point == $null) {
        set %2point @ $+ %var
      }
      else {
        set %2point %2point $+ $chr(44) $+ $chr(32) $+ @ $+ %var
      }
    }
    elseif (%bomb. [ $+ [ %var ] ] == $calc($$1 + 1) || %bomb. [ $+ [ %var ] ] == $calc($$1 - 1)) {
      if (%bomb. [ $+ [ %var ] ] >= 0) {
        inc %leaderboard. [ $+ [ %var ] ] 1
        if (%1point == $null) {
          set %1point @ $+ %var
        }
        else {
          set %1point %1point $+ $chr(44) $+ $chr(32) $+ @ $+ %var
        }

      }
    }
    inc %i
  }
  if (%2point == $null) {
    msg $active Nobody guessed $1.
  }
  else {
    msg $active For guessing $1, 2 points to %2point
  }
  if (%1point != $null) {
    msg $active For being only 1 off of $1, 1 point to %1point
  }
  unset %bomb*
}

alias cysWinners {
  echo -a $$1
  var %1point, %5point
  var %i = 1, %n = $var(cys $+ *,0), %var
  while (%i <= %n) {
    %var = $gettok($var(cys $+ *,%i),2-,46)
    if (%cys. [ $+ [ %var ] ] == $$1) {
      inc %leaderboard. [ $+ [ %var ] ] 5
      if (%5point == $null) {
        set %5point @ $+ %var
      }
      else {
        set %5point %5point $+ $chr(44) $+ $chr(32) $+ @ $+ %var
      }
    }
    elseif (%cys. [ $+ [ %var ] ] == $calc($$1 + 1) || %cys. [ $+ [ %var ] ] == $calc($$1 - 1)) {
      if (%cys. [ $+ [ %var ] ] >= 0) {
        inc %leaderboard. [ $+ [ %var ] ] 1
        if (%1point == $null) {
          set %1point @ $+ %var
        }
        else {
          set %1point %1point $+ $chr(44) $+ $chr(32) $+ @ $+ %var
        }

      }
    }
    inc %i
  }
  if (%5point == $null) {
    msg $active Nobody guessed $$1.
  }
  else {
    msg $active For guessing $$1, 5 points to %5point
  }
  if (%1point != $null) {
    msg $active For being only 1 off of $$1, 1 point to %1point
  }
  unset %cys*
}

alias sandstormWinners {
  var %1point, %2point
  var %i = 1, %n = $var(sandstorm $+ *,0), %var
  while (%i <= %n) {
    %var = $gettok($var(sandstorm $+ *,%i),2-,46)
    if (%sandstorm. [ $+ [ %var ] ] == $$1) {
      inc %leaderboard. [ $+ [ %var ] ] 2
      if (%2point == $null) {
        set %2point @ $+ %var
      }
      else {
        set %2point %2point $+ $chr(44) $+ $chr(32) $+ @ $+ %var
      }
    }
    elseif (%sandstorm. [ $+ [ %var ] ] == $calc($$1 + 1) || %sandstorm. [ $+ [ %var ] ] == $calc($$1 - 1)) {
      if (%sandstorm. [ $+ [ %var ] ] >= 0) {
        inc %leaderboard. [ $+ [ %var ] ] 1
        if (%1point == $null) {
          set %1point @ $+ %var
        }
        else {
          set %1point %1point $+ $chr(44) $+ $chr(32) $+ @ $+ %var
        }

      }
    }
    inc %i
  }
  if (%2point == $null) {
    msg $active Nobody guessed $$1.
  }
  else {
    msg $active For guessing $$1, 2 points to %2point
  }
  if (%1point != $null) {
    msg $active For being only 1 off of $$1, 1 point to %1point
  }
  unset %sandstorm*
}
