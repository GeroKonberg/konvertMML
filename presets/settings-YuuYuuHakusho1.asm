;konvertMML settings
!ReadFile = "input.spc"

!ReadAddr = $D7F4
!OutAddr = $0200
!ProgAddr = $B000

!ReadIndex = $01

incsrc "asm/readV120.asm"