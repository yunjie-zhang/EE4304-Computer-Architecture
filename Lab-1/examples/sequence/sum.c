#include <stdio.h>
void main(){
	int start = 1;
	int end = 200;
	int step = 3;
	int result = 0;
	int sum_val = 0;

	while(start < end){
		sum_val += start;
		start += step;
	}
	result = sum_val;
	printf("%d", result);

}
