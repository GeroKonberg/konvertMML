;konvertMML settings
!ReadFile = "input.spc"

!ReadAddr = $143D
!OutAddr = $7000
!ProgAddr = $F000

!ReadIndex = $04

incsrc "asm/readV120.asm"