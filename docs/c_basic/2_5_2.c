#include<stdio.h>

int main(void)
{
	int a=10;
	int b=-15;
	int sum=a+b;
	int dif=a-b;
	
	
	sum=(sum%360+360)%360;
	dif=(dif%360+360)%360;
	
	printf("sum=%d dif=%d\n",sum,dif);
	
	return 0;
}