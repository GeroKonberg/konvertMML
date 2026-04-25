;konvertMML settings
!ReadFile = "input.spc"

!ReadAddr = $15D9
!OutAddr = $7000
!ProgAddr = $F000

!ReadIndex = $01

incsrc "asm/readV120.asm"