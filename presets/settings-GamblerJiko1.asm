;konvertMML settings
!ReadFile = "input.spc"

!ReadAddr = $0DB0
!OutAddr = $1000
!ProgAddr = $D000

!ReadIndex = $01

incsrc "asm/readV120.asm"