;konvertMML settings
!ReadFile = "input.spc"

!ReadAddr = $15BD
!OutAddr = $0200
!ProgAddr = $B800

!ReadIndex = $01

incsrc "asm/readV120.asm"