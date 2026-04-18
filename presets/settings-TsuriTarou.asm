;konvertMML settings
!ReadFile = "input.spc"

!ReadAddr = $19ED
!OutAddr = $7000
!ProgAddr = $F000

!ReadIndex = $02

incsrc "asm/readArcs.asm"