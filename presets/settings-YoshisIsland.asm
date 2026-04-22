;konvertMML settings
!ReadFile = "input.spc"

!ReadAddr = $FF90
!OutAddr = $0200
!ProgAddr = $8000

!ReadIndex = $01

incsrc "asm/readV120.asm"