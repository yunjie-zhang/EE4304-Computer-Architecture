#include <stdio.h>

void main(){
	int size = 10;
	int result = 0;
	int array[] = {0, 2, 4, 6, 8, 10, 12, 14, 16, 18};
	int cnt = 0;
	while(size > 0){
		result += array[cnt];
		size -= 1;
		cnt += 1;
	}
	printf("%d", result);

}
