;konvertMML settings
!ReadFile = "input.spc"

!ReadAddr = $C800
!OutAddr = $0200
!ProgAddr = $B800

!ReadIndex = $03

incsrc "asm/readV120.asm"