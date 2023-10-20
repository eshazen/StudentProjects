# Toddler Camera

See [Electrical Function](Electrical Function-1.pdf) document for some details.

## Notes

* The biggest challenges are mechanics and software.

* Auto-Focus is critical.

* The electronics itself would be very robust... it's the connectors,
display, controls, and camera which will need protection.

* I highly recommend wireless charging as a USB connector is pretty
  easy to damage or contaminate with dirt.  Check out the "Qi"
  standard for wireless charging.
  
* What about a flash / light for low-light conditions?

## Technical issues / ideas

* What interface?  R-Pi uses MIPI.  This isn't easy to
  decode/convert, unless you use a RPi.
  
* A raspberry pi zero might be a good MCU.  Maybe a P-zero W or a
  compute module 4?
  
* What resolution for the cameras?

* What storage?  Built-in or uSD card or proprietary?

* WiFi or bluetooth for image download or something else?

* Battery?  Probably not LiPo due to safety.  Ideally it is removable,
  or can even run on disposables (e.g. AA) as an option.
  
  
