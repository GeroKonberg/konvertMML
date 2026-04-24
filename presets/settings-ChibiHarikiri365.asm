;konvertMML settings
!ReadFile = "input.spc"

!ReadAddr = $4710
!OutAddr = $0200
!ProgAddr = $F000

!ReadIndex = $01

incsrc "asm/readV120.asm"