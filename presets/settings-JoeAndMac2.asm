;konvertMML settings
!ReadFile = "input.spc"

!ReadAddr = $051B
!OutAddr = $0200
!ProgAddr = $9000

!ReadIndex = $01

incsrc "asm/readV120.asm"