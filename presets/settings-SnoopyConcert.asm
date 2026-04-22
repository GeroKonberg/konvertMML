;konvertMML settings
!ReadFile = "input.spc"

!ReadAddr = $283D
!OutAddr = $7000
!ProgAddr = $F000

!ReadIndex = $02

incsrc "asm/readV120.asm"