;konvertMML settings
!ReadFile = "input.spc"

!ReadAddr = $A91A
!OutAddr = $0200
!ProgAddr = $9800

!ReadIndex = $01

incsrc "asm/readV120.asm"