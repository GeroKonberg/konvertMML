;konvertMML settings
!ReadFile = "input.spc"

!ReadAddr = $B2E8
!OutAddr = $0200
!ProgAddr = $A000

!ReadIndex = $01

incsrc "asm/readV120.asm"