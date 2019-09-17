#include <stdio.h>
void main(){
	unsigned int x = 4;
	unsigned int result = 0;
	unsigned int s2 = 1;
	while(x != 0){
		x-=1;
		s2<<=1;
	}
	result = s2;
	printf("%d", result);
}

