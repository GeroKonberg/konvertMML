;konvertMML settings
!ReadFile = "input.spc"

!ReadAddr = $0CA0
!OutAddr = $6000
!ProgAddr = $F000

!ReadIndex = $01

incsrc "asm/readVKon2a6.asm"