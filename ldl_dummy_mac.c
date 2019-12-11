#include "ldl_mac.h"
#include "ldl_sm.h"
#include <string.h>

void dummy_mac_state(void)
{
    static struct ldl_mac mac;
    static struct ldl_sm sm;
    
    memset(&mac, 0, sizeof(mac));
    memset(&sm, 0, sizeof(sm));
}
