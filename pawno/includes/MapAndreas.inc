#if defined _MapAndreas_Included
        #endinput
#endif
 
#define _MapAndreas_Included
 
stock Float: GetPointZPos(const Float: fX, const Float: fY, &Float: fZ = 0.0) {
        if(!((-3000.0 < fX < 3000.0) && (-3000.0 < fY < 3000.0))) {
                return 0.0;
        }
        static
                File: s_hMap
        ;
        if(!s_hMap) {
                s_hMap = fopen("SAfull.hmap", io_read);
               
                if(!s_hMap) {
                        return 0.0;
                }
        }
        new
                afZ[1]
        ;
        fseek(s_hMap, ((6000 * (-floatround(fY, floatround_tozero) + 3000) + (floatround(fX, floatround_tozero) + 3000)) << 1));
        fblockread(s_hMap, afZ);
       
        return (fZ = ((afZ[0] >>> 16) * 0.01));
}