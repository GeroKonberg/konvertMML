;konvertMML settings
!ReadFile = "input.spc"

!ReadAddr = $16E2
!OutAddr = $7000
!ProgAddr = $F000

!ReadIndex = $02

incsrc "asm/readV120.asm"