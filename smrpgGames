alias startCroco {
  msg $active How many bombs will Croco toss? 1 minute to guess! Type !bomb $chr(35)
}
alias startMinecart {
  msg $active What will today's Minecart time be? 1 minute to guess! Type !minecart $chr(35) $+ : $+ $chr(35) $+ $chr(35) $+ : $+ $chr(35) $+ $chr(35)
}
alias startCys {
  msg $active It's time to Call Your Shot! How many flowers (0-16) on Booster Hill? 1 minute to guess! Type !cys $chr(35)
}
alias startCake {
  msg $active How many Sandstorms will Bundt use? 1 minute to guess! Type !sandstorm $chr(35)
}

alias regextest {
  if ($regex($$1,(\d)(\.|:)(\d\d)(\.|:)(\d\d))) {
    //echo -a $calc($regml(1) * 6000 + $regml(3) * 100 + $regml(5))
  }

}
on *:TEXT:*:#:{
  if (%gameActive == on && %accept == on) {
    if (%gameCounter == 1 && $$1 == !bomb && $$2 isnum) {
      set %bomb. $+ $nick  $$2
    }
    elseif (%gameCounter == 2 && $$1 == !minecart) {
      if ($regex($$2,(\d)(\.|:)(\d\d)(\.|:)(\d\d))) {
        var %timestamp = $calc($regml(1) * 6000 + $regml(3) * 100 + $regml(5))
        if (%timestamp <= 15000) {
          set %minecart. $+ $nick  %timestamp
        }
      }
    }
    elseif (%gameCounter == 3 && $$1 == !cys && $$2 isnum) {
      set %cys. $+ $nick  $$2
    }
    elseif (%gameCounter == 4 && $$1 == !sandstorm && $$2 isnum) {
      set %sandstorm. $+ $nick  $$2
    }
  }
}
