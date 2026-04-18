;konvertMML settings
!ReadFile = "input.spc"

!ReadAddr = $187F
!OutAddr = $7000
!ProgAddr = $F000

!ReadIndex = $04

incsrc "asm/readArcs.asm"