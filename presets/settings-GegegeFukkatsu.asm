;konvertMML settings
!ReadFile = "input.spc"

!ReadAddr = $F83B
!OutAddr = $7000
!ProgAddr = $E000

!ReadIndex = $01

incsrc "asm/readV120.asm"