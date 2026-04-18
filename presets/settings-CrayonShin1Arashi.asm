;konvertMML settings
!ReadFile = "input.spc"

!ReadAddr = $141B
!OutAddr = $7000
!ProgAddr = $F000

!ReadIndex = $02

incsrc "asm/readArcs.asm"