arduino_ldl
===========

An Arduino library that wraps [LDL](https://github.com/cjhdev/lora_device_lib).

This wrapper is intended for use with the ATMEGA328P.

## Limitations

A number of features have been removed from LDL to make it fit comfortably
on the 328P.

- Will not work with LoRaWAN 1.1 servers
- Some MAC commands have been removed
    - LinkCheckReq/Ans
    - DeviceTimeReq/Ans
    - DlSetupReq/Ans (will still respond to server but will not change state)
- Number of channels reduced from 16 to 8

## Further Optimisation

The wrapper can be further optimised by changing the definitions in in [platform.h](platform.h).

The full set of of build-time options are documented [here](https://cjhdev.github.io/lora_device_lib_api/group__ldl__optional.html).

## Interface

See [arduino_ldl.h](arduino_ldl.h).

Reset, select, and dio pins can be moved to suit your hardware. All
of these connections are required for correct operation.

## Flash/RAM Usage

[examples/mbed_sx1272_small_code](examples/mbed_sx1272_small_code) requires ~24KB of flash and ~800B of RAM.

## Example

In this example a node will:

- attempt to join
- once joined, send an empty data message to port 1 as often as the TTN fair access policy allows
- manage data rate and power using ADR

~~~ C++
#include <arduino_ldl.h>

static void get_identity(struct arduino_ldl_id *id)
{       
    static const struct arduino_ldl_id _id PROGMEM = {
        {0x00U,0x00U,0x00U,0x00U,0x00U,0x00U,0x00U,0x00U},                                                  /* joinEUI/appEUI */
        {0x00U,0x00U,0x00U,0x00U,0x00U,0x00U,0x00U,0x01U},                                                  /* devEUI */
        {0x2bU,0x7eU,0x15U,0x16U,0x28U,0xaeU,0xd2U,0xa6U,0xabU,0xf7U,0x15U,0x88U,0x09U,0xcfU,0x4fU,0x3cU}   /* nwkKey */
    };

    memcpy_P(id, &_id, sizeof(*id));
}

LDL::MAC& get_ldl()
{
    static LDL::SX1272 radio(
        LDL_RADIO_PA_RFO,   /* specify power amplifier */
        A0,                 /* radio reset pin */
        10,                 /* radio select pin */
        2,                  /* radio dio0 pin */
        3                   /* radio dio1 pin */
    );
    
    static LDL::MAC mac(
        radio,              /* mac needs a radio */
        LDL_EU_863_870,     /* specify region */
        get_identity        /* specify name of function that returns euis and keys */               
    );
    
    return mac;
}

void setup() 
{
}

void loop() 
{ 
    LDL::MAC& ldl = get_ldl();
    
    if(ldl.ready()){
    
        if(ldl.joined()){
        
            ldl.unconfirmedData(1U);                 
        }
        else{
         
            ldl.otaa();
        }
    }    
    
    ldl.process();        
}
~~~

More [examples](examples).

## Hints

- debug information is only printed if you configure your sketch to do it via the ArduinoLDL.onEvent() callback (see "*_debug_node" examples for how)
- not printing debug information can save kilobytes of program space
- if you are printing debug information, remember to init the Serial object
- ArduinoLDL.eventDebug() uses less codespace than ArduinoLDL.eventDebugVerbose()
- ArduinoLDL has ADR enabled by default (use ArduinoLDL.disableADR() to disable)
- ArduinoLDL limits to approximately the TTN fair access policy by default (use ArduinoLDL.setMaxDCycle() to change)
- If OTAA is timing out when it should be succeeding it might be a repeat devNonce (try resetting the Arduino)

## License

MIT
