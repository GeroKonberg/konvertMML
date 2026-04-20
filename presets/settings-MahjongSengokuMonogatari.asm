;konvertMML settings
!ReadFile = "input.spc"

!ReadAddr = $1261
!OutAddr = $2000
!ProgAddr = $C000

!ReadIndex = $01

incsrc "asm/readV120.asm"