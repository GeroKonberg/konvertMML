;konvertMML settings
!ReadFile = "input.spc"

!ReadAddr = $5820
!OutAddr = $7000
!ProgAddr = $F000

!ReadIndex = $05

incsrc "asm/readV120.asm"