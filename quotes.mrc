on *:TEXT:!addquote*:#:{
  if ($nick isop $chan) {
    /write quotes.txt $$2-
    msg $active Quote added.
  }
  else {
    msg $active Only channel mods can add quotes.
  }
}
on *:TEXT:!quote:#:{
  if (%dontquote == $null) {
    if ($2-) {
      msg $active Quote: $read(quotes.txt, w, * $+ $2- $+ *)
    }
    else {
      msg $active Quote: $read(quotes.txt)
    }
    set -u10 %dontquote true
  }
}
