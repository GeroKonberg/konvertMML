;konvertMML settings
!ReadFile = "input.spc"

!ReadAddr = $0FFB
!OutAddr = $7000
!ProgAddr = $F000

!ReadIndex = $05

incsrc "asm/readV120.asm"