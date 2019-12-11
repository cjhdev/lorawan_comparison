#include "ldl_radio.h"
#include <string.h>

void dummy_radio_state(void)
{
    static struct ldl_radio radio;
    
    memset(&radio, 0, sizeof(radio));    
}
