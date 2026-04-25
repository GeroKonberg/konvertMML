;konvertMML settings
!ReadFile = "input.spc"

!ReadAddr = $1300
!OutAddr = $7000
!ProgAddr = $F000

!ReadIndex = $03

incsrc "asm/readV120.asm"