;konvertMML settings
!ReadFile = "input.spc"

!ReadAddr = $08CD
!OutAddr = $6000
!ProgAddr = $F000

!ReadIndex = $01

incsrc "asm/readVKon2a6.asm"