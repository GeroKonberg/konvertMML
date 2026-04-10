;konvertMML settings
!ReadFile = "input.spc"

!ReadAddr = $10CB
!OutAddr = $8000
!ProgAddr = $F000

!ReadIndex = $01

incsrc "asm/readVKon2a6.asm"