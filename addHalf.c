//author: sspsk Email:kdstsdk@gmail.com
//-------------------------------------
half addhalf( const half a, const half b ) {

  half sum = 0;
  unsigned int m_a = a & 0x3ff;
  unsigned int e_a = (a>>10) & 0x1f;
  unsigned int s_a = (a>>15);

  unsigned int m_b = b & 0x3ff;
  unsigned int e_b = (b>>10) & 0x1f;
  unsigned int s_b = (b>>15) ;

  unsigned int s,e,m;
  unsigned int temp,temp1,temp2;
  if(a == 0 && b ==0)return 0;
  temp1 = m_a | 0x400;        //significant a
  temp2 = m_b | 0x400;        //significant b
  if(e_a>e_b){                       //-----------
    temp2 = temp2 >> (e_a -e_b);     //-----------
    e_b = e_a;                       //making the exponents to be the same
  }                                  //-----------
  else{                              //-----------
    temp1 = temp1 >> (e_b -e_a);     //-----------
    e_a = e_b;                       //-----------
  }                                  //-----------
  e=e_a;                             //the final exponent will be the same

if(s_a == s_b){                     //check for same sign
      s = s_a;
      temp = temp1 + temp2;
      if((temp >>10) != 1){
        temp = temp >> 1;
          e++;
      }
  }
else{                                //different sign
  if(temp1 == temp2){
      return 0;
   }
  if(temp1>temp2){                   //adding  the fractions
        s = s_a;
        temp = temp1-temp2;
      }
  else {                            //---||---
        s= s_b;
        temp = temp2-temp1;
      }

   while((temp & 0x400) == 0){      //shifting left till we have 1 in the left side of the point(.)
      temp =  temp<<1;
       e--;
     }
    }
    m = temp;





 sum = (s << 15) | e << 10 | (m & 0x3ff);
  return sum;

}
