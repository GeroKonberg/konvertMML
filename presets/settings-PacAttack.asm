;konvertMML settings
!ReadFile = "input.spc"

!ReadAddr = $C138
!OutAddr = $0200
!ProgAddr = $B000

!ReadIndex = $01

incsrc "asm/readV120.asm"