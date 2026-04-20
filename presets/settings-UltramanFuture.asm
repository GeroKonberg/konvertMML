;konvertMML settings
!ReadFile = "input.spc"

!ReadAddr = $188E
!OutAddr = $7000
!ProgAddr = $F000

!ReadIndex = $01

incsrc "asm/readV120.asm"