# 2024-04-17

Tested out power supply board.  Battery (6V) to 5V via LDO, then to
two DC/DC converters to provide +/-75V.

Schematic (PDF):  [Schematic](BatteryPCB.pdf)

Works OK with bench power.  Draws 125mA at 6V with both converters
operating.  Requires current limit at 500mA for successful power-up.

Added 100k load resistors on each converter output, otherwise they
don't regulate properly.  Adjusted each for 75V output.

Does _not_ power up with 4xAA batteries.  Battery voltage drops below
5V LDO headroom and everything locks up.

Plan is to try with 12V from 8xAA batteries or maybe C cells.

