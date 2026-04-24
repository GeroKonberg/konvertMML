;konvertMML settings
!ReadFile = "input.spc"

!ReadAddr = $30F3
!OutAddr = $0200
!ProgAddr = $B800

!ReadIndex = $03

incsrc "asm/readV120.asm"