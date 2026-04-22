;konvertMML settings
!ReadFile = "input.spc"

!ReadAddr = $1570
!OutAddr = $1600
!ProgAddr = $C000

!ReadIndex = $01

incsrc "asm/readV120.asm"