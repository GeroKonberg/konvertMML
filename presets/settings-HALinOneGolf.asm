;konvertMML settings
!ReadFile = "input.spc"

!ReadAddr = $4C00
!OutAddr = $8000
!ProgAddr = $F000

!ReadIndex = $04

incsrc "asm/readV120.asm"