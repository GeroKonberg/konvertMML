;konvertMML settings
!ReadFile = "input.spc"

!ReadAddr = $1705
!OutAddr = $0200
!ProgAddr = $B800

!ReadIndex = $01

incsrc "asm/readV120.asm"