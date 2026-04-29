;konvertMML settings
!ReadFile = "input.spc"

!ReadAddr = $8000
!OutAddr = $0200
!ProgAddr = $7000

!ReadIndex = $01

incsrc "asm/readV120.asm"