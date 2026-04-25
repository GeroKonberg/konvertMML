;konvertMML settings
!ReadFile = "input.spc"

!ReadAddr = $12A5
!OutAddr = $0200
!ProgAddr = $C000

!ReadIndex = $01

incsrc "asm/readV120.asm"