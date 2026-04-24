;konvertMML settings
!ReadFile = "input.spc"

!ReadAddr = $2F96
!OutAddr = $0200
!ProgAddr = $B800

!ReadIndex = $03

incsrc "asm/readV120.asm"