#include <CapacitiveSensor.h>
CapacitiveSensor   cs_4_2 = CapacitiveSensor(6, 4); 


void setup()                    
{

   cs_4_2.set_CS_AutocaL_Millis(0xFFFFFFFF);     
   Serial.begin(9600);

}

void loop()                    
{
    
    long total1 =  cs_4_2.capacitiveSensor(30);
    
    //Serial.println(total1); 
    // print sensor output 1
    
    if (total1 > 3) {
        Serial.println('1');
    } else {
        Serial.println('0'); 
    }
    
             
    delay(10);                             // arbitrary delay to limit data to serial port 
}
