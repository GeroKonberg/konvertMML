;konvertMML settings
!ReadFile = "input.spc"

!ReadAddr = $DA00
!OutAddr = $0200
!ProgAddr = $C000

!ReadIndex = $01

incsrc "asm/readV120.asm"